import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_name_key() i64 {
	return 0
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_location_key() i64 {
	return 2
}
struct Class_Automattic_WooCommerce_Internal_Admin_Marketing {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Marketing.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) construct()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketing', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_pages' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketing', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_parent_menu_item' }]), rt.new_int(6)])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketing', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reorder_marketing_submenu' }]), rt.new_int(99)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shared_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketing', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'component_settings' }]), rt.new_int(30)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) add_parent_menu_item()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('navigation')))))) {
		rt.call_function('add_menu_page', [rt.call_function('__', [rt.new_string('Marketing'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('Marketing'), rt.new_string('woocommerce')]), rt.new_string('manage_woocommerce'), rt.new_string('woocommerce-marketing'), rt.new_null(), rt.new_string('dashicons-megaphone'), rt.new_int(58)])
	}
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }(), 'connect_page', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-marketing' }, rt.ArrayItem{ key: 'title', val: 'Marketing' }, rt.ArrayItem{ key: 'capability', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'path', val: 'wc-admin&path=/marketing' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) register_pages()  {
	this.register_overview_page()
	mut var_controller := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }()
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'parent', val: 'woocommerce-marketing' }, rt.ArrayItem{ key: 'existing_page', val: false }])
	mut var_marketing_pages := rt.call_function('apply_filters', [rt.new_string('woocommerce_marketing_menu_items'), rt.new_array()])
	{
		mut iter_1 := var_marketing_pages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_marketing_page := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_marketing_page.dup().is_array()))))) {
				continue
			}
			var_marketing_page = rt.call_function('array_merge', [var_defaults.dup(), var_marketing_page.dup()])
			if rt.is_true(var_marketing_page.array_get('existing_page')) {
				rt.call_method(var_controller, 'connect_page', [var_marketing_page.dup()])
			} else {
				rt.call_method(var_controller, 'register_page', [var_marketing_page.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) register_overview_page()  {
	mut var_submenu := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.get_instance() }(), 'register_page', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-marketing-overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'path', val: 'wc-admin&path=/marketing' }, rt.ArrayItem{ key: 'parent', val: 'woocommerce-marketing' }])])
	if !(var_submenu.array_isset(rt.new_string('woocommerce-marketing'))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_submenu.array_get('woocommerce-marketing').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_item.array_get(2), rt.new_string('wc-admin')]))) {
				var_item.array_set(2, 'admin.php?page=' + (var_item.array_get(2)).str())
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) reorder_marketing_submenu()  {
	mut var_submenu := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_submenu.array_isset(rt.new_string('woocommerce-marketing'))) {
		return rt.new_null()
	}
	mut var_marketing_submenu := var_submenu.array_get('woocommerce-marketing')
	mut var_new_menu_order := rt.new_array()
	mut var_overview_key := rt.call_function('array_search', [rt.new_string('Overview'), rt.call_function('array_column', [var_marketing_submenu.dup(), Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_name_key()]), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_overview_key)) {
		var_overview_key = rt.call_function('array_search', [rt.new_string('admin.php?page=wc-admin&path=/marketing'), rt.call_function('array_column', [var_marketing_submenu.dup(), Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_location_key()]), rt.new_bool(true)])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_new_menu_order.array_push(var_marketing_submenu.array_get(var_overview_key))
		rt.call_function('array_splice', [var_marketing_submenu.dup(), var_overview_key.dup(), rt.new_int(1)])
	}
	mut var_coupons_key := rt.call_function('array_search', [rt.new_string('Coupons'), rt.call_function('array_column', [var_marketing_submenu.dup(), Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_name_key()]), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_coupons_key)) {
		var_coupons_key = rt.call_function('array_search', [rt.new_string('edit.php?post_type=shop_coupon'), rt.call_function('array_column', [var_marketing_submenu.dup(), Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Marketing.submenu_location_key()]), rt.new_bool(true)])
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_new_menu_order.array_push(var_marketing_submenu.array_get(var_coupons_key))
		rt.call_function('array_splice', [var_marketing_submenu.dup(), var_coupons_key.dup(), rt.new_int(1)])
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return rt.call_function('strcmp', [var_a.array_get(0), var_b.array_get(0)])
	}
	rt.call_function('usort', [var_marketing_submenu.dup(), rt.new_closure(closure_1_fn)])
	var_new_menu_order = rt.call_function('array_merge', [var_new_menu_order.dup(), var_marketing_submenu.dup()])
	var_submenu.array_set('woocommerce-marketing', var_new_menu_order.dup())
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) component_settings(var_settings rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PageController{}; return temp.is_admin_page() }())))) {
		return var_settings.dup()
	}
	var_settings.array_get_mut('marketing').array_set('installedExtensions', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions{}; return temp.get_data() }())
	return var_settings.dup()
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_marketing() &Class_Automattic_WooCommerce_Internal_Admin_Marketing {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Marketing{
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

fn create_automattic_woocommerce_admin_marketing_installedextensions() &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_Marketing.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_parent_menu_item' {
			this.add_parent_menu_item()
			return rt.new_null()
		}
		'register_pages' {
			this.register_pages()
			return rt.new_null()
		}
		'register_overview_page' {
			this.register_overview_page()
			return rt.new_null()
		}
		'reorder_marketing_submenu' {
			this.reorder_marketing_submenu()
			return rt.new_null()
		}
		'component_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.component_settings(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Marketing) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketing) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Marketing_InstalledExtensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_marketing_php() {
}
