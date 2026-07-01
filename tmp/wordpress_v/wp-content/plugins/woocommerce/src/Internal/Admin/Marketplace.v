import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Marketplace.marketplace_tab_slug() string {
	return 'woo'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Marketplace {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) init()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketplace', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_init' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) on_init()  {
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketplace', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_pages' }]), rt.new_int(70)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketplace', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
	rt.call_function('add_filter', [rt.new_string('install_plugins_tabs'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketplace', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_woo_plugin_install_action_link' }])])
	rt.call_function('add_action', [rt.new_string('install_plugins_pre_woo'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Marketplace', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_open_woo_tab' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) register_pages()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_admin_register_page')]))))) {
		return rt.new_null()
	}
	mut var_marketplace_pages := this.get_marketplace_pages()
	{
		mut iter_1 := var_marketplace_pages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_marketplace_page := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_marketplace_page.dup().is_null()))))) {
				rt.call_function('wc_admin_register_page', [var_marketplace_page.dup()])
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) get_marketplace_pages() rt.PhpVal {
	mut var_marketplace_pages := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce-marketplace' }, rt.ArrayItem{ key: 'parent', val: 'woocommerce' }, rt.ArrayItem{ key: 'title', val: (rt.call_function('__', [rt.new_string('Extensions'), rt.new_string('woocommerce')])).str() + this.badge() }, rt.ArrayItem{ key: 'page_title', val: rt.call_function('__', [rt.new_string('Extensions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'path', val: '/extensions' }]) }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_marketplace_menu_items'), var_marketplace_pages.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) badge() string {
	mut var_option := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Helper_Options{}; return temp.get(arg_0) }(rt.new_string('my_subscriptions_tab_loaded'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_option)))) {
		return (fn () rt.PhpVal { mut temp := Class_WC_Helper_Updater{}; return temp.get_updates_count_html() }()).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) enqueue_scripts(var_hook_suffix rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('path'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) add_woo_plugin_install_action_link(var_tabs rt.PhpVal) rt.PhpVal {
	mut var_tabs_mutated := var_tabs
	var_tabs_mutated.array_set(Class_Automattic_WooCommerce_Internal_Admin_Automattic_WooCommerce_Internal_Admin_Marketplace.marketplace_tab_slug(), 'WooCommerce Marketplace')
	return var_tabs_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) maybe_open_woo_tab()  {
	if rt.is_true(rt.new_bool(!(rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_woo_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'page', val: 'wc-admin' }, rt.ArrayItem{ key: 'path', val: '/extensions' }, rt.ArrayItem{ key: 'tab', val: 'extensions' }, rt.ArrayItem{ key: 'ref', val: 'plugins' }]), rt.call_function('admin_url', [rt.new_string('admin.php')])])
	rt.call_function('wc_admin_record_tracks_event', [rt.new_string('marketplace_plugin_install_woo_clicked')])
	rt.call_function('wp_safe_redirect', [var_woo_url.dup()])
	// unsupported expression: Expr_Exit
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Updater {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_marketplace() &Class_Automattic_WooCommerce_Internal_Admin_Marketplace {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Marketplace{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_options() &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper_updater() &Class_WC_Helper_Updater {
	mut obj := &Class_WC_Helper_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'register_pages' {
			this.register_pages()
			return rt.new_null()
		}
		'get_marketplace_pages' {
			return this.get_marketplace_pages()
		}
		'badge' {
			return rt.new_string(this.badge())
		}
		'enqueue_scripts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enqueue_scripts(dispatch_arg_0)
			return rt.new_null()
		}
		'add_woo_plugin_install_action_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_woo_plugin_install_action_link(dispatch_arg_0)
		}
		'maybe_open_woo_tab' {
			this.maybe_open_woo_tab()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Marketplace) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Marketplace) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_marketplace_php() {
}
