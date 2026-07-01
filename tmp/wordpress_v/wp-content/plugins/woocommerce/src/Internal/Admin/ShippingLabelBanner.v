import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner.min_compatible_wcst_version() string {
	return '2.7.0'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner.min_compatible_wcshipping_version() string {
	return '1.1.0'
}
struct Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner {
	rt.PhpObjectBase
pub mut:
		shipping_label_banner_display_rules rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) construct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('add_meta_boxes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_meta_boxes' }]), rt.new_int(6), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) should_show_meta_box() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.shipping_label_banner_display_rules)))) {
		mut var_dotcom_connected := rt.new_null()
		mut var_wcs_version := rt.new_null()
		if rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Manager.class()])) {
			var_dotcom_connected = rt.call_method(create_automattic_jetpack_connection_manager(), 'has_connected_owner', []rt.PhpVal{})
		}
		if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\Automattic\\WCShipping\\Utils')])) {
			var_wcs_version = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils{}; return temp.get_wcshipping_version() }()
		}
		mut var_incompatible_plugins := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Shipping_Fedex_Init')])) || rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Shipping_UPS_Init')])))) || rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Integration_ShippingEasy')])))) || rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_ShipStation_Integration')]))))
		this.shipping_label_banner_display_rules = create_automattic_woocommerce_internal_admin_shippinglabelbannerdisplayrules(var_dotcom_connected.dup(), var_wcs_version.dup(), var_incompatible_plugins.dup())
	}
	return rt.call_method(this.shipping_label_banner_display_rules, 'should_display_banner', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) add_meta_boxes()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_OrderUtil{}; return temp.is_order_edit_screen() }())))) {
		return rt.new_null()
	}
	if rt.is_true(this.should_show_meta_box()) {
		rt.call_function('add_meta_box', [rt.new_string('woocommerce-admin-print-label'), rt.call_function('__', [rt.new_string('Shipping Label'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'meta_box' }]), rt.new_null(), rt.new_string('normal'), rt.new_string('high'), rt.create_array([rt.ArrayItem{ key: 'context', val: 'shipping_label' }])])
		rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_print_shipping_label_script' }])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) count_shippable_items(mut var_order Class_Automattic_WooCommerce_Internal_Admin_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_count := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Internal_Admin_WC_Order_Item_Product'))) {
				mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'needs_shipping', []rt.PhpVal{})))) {
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	return var_count.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) add_print_shipping_label_script(var_hook rt.PhpVal)  {
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_style(arg_0, arg_1, arg_2) }(rt.new_string('print-shipping-label-banner'), rt.new_string('style'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }]))
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('print-shipping-label-banner'), rt.new_bool(true))
	mut var_wcst_version := rt.new_null()
	mut var_wcshipping_installed_version := rt.new_null()
	mut var_order := rt.call_function('wc_get_order', []rt.PhpVal{})
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('\\WC_Connect_Loader')])) {
		var_wcst_version = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader{}; return temp.get_wcs_version() }()
	}
	mut var_wc_shipping_plugin_file := rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/woocommerce-shipping/woocommerce-shipping.php')
	if rt.is_true(rt.call_function('file_exists', [var_wc_shipping_plugin_file.dup()])) {
		mut var_plugin_data := rt.call_function('get_plugin_data', [var_wc_shipping_plugin_file.dup()])
		var_wcshipping_installed_version = var_plugin_data.array_get('Version')
	}
	mut var_payload := rt.create_array([rt.ArrayItem{ key: 'is_wcst_compatible', val: if rt.is_true(var_wcst_version) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(1) } }, rt.ArrayItem{ key: 'order_id', val: if rt.is_true(var_order) { rt.call_method(var_order, 'get_id', []rt.PhpVal{}) } else { rt.new_null() } }, rt.ArrayItem{ key: 'is_incompatible_wcshipping_installed', val: if rt.is_true(var_wcshipping_installed_version) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) } }])
	rt.call_function('wp_localize_script', [rt.new_string('wc-admin-print-shipping-label-banner'), rt.new_string('wcShippingCoreData'), var_payload.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) meta_box(var_post rt.PhpVal, var_args rt.PhpVal)  {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string('wc-admin-shipping-banner')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_json_encode', [var_args.array_get('args')])]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_Automattic_Jetpack_Connection_Manager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_shippinglabelbanner() &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner{
		PhpObjectBase: rt.PhpObjectBase{}
		shipping_label_banner_display_rules: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_jetpack_connection_manager() &Class_Automattic_Jetpack_Connection_Manager {
	mut obj := &Class_Automattic_Jetpack_Connection_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_automattic_wcshipping_utils() &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_shippinglabelbannerdisplayrules() &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil() &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn create_automattic_woocommerce_internal_admin_wc_connect_loader() &Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'should_show_meta_box' {
			return this.should_show_meta_box()
		}
		'add_meta_boxes' {
			this.add_meta_boxes()
			return rt.new_null()
		}
		'count_shippable_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.count_shippable_items(mut dispatch_arg_0)
		}
		'add_print_shipping_label_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_print_shipping_label_script(dispatch_arg_0)
			return rt.new_null()
		}
		'meta_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.meta_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'shipping_label_banner_display_rules' { return this.shipping_label_banner_display_rules }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBanner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'shipping_label_banner_display_rules' { this.shipping_label_banner_display_rules = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Connection_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Connection_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Automattic_WCShipping_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ShippingLabelBannerDisplayRules) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WC_Connect_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_shippinglabelbanner_php() {
}
