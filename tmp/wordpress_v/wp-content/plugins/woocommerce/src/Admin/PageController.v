import rt

pub fn Class_Automattic_WooCommerce_Admin_PageController.app_entry_point() string {
	return 'wc-admin'
}
pub fn Class_Automattic_WooCommerce_Admin_PageController.page_root() string {
	return 'wc-admin'
}
struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_bool(false)
		current_page rt.PhpVal = rt.new_null()
		pages rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Admin_PageController.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_page_handler' }])])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_store_details_page' }])])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_app_entry_page_menu_item' }]), rt.new_int(20)])
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_PageController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_redirect_payment_tasks_to_settings' }]), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) connect_page(var_options rt.PhpVal)  {
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_options_mutated.array_get('title').is_array()))))) {
		var_options_mutated.array_set('title', rt.create_array([rt.ArrayItem{ key: none, val: var_options_mutated.array_get('title') }]))
	}
	var_options_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_connect_page_options'), var_options_mutated.dup()])
	mut var_id := if !(var_options_mutated.array_get('id')).is_null() { var_options_mutated.array_get('id') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_id.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.pages.array_set(var_id, var_options_mutated.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) determine_current_page()  {
	mut var_current_pieces := rt.new_null()
	mut var_current_url := rt.new_string(rt.new_string(''))
	mut var_current_screen_id := this.get_current_screen_id()
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('REQUEST_URI')) {
		var_current_url = rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('REQUEST_URI')])])
	}
	mut var_current_query := rt.call_function('wp_parse_url', [var_current_url.dup(), rt.get_constant('PHP_URL_QUERY')])
	rt.call_function('parse_str', [// unsupported expression: Expr_Cast_String, var_current_pieces.dup()])
	mut var_current_path := if !rt.is_true(var_current_pieces.array_get('page')) { rt.new_string('') } else { var_current_pieces.array_get('page') }
	// unsupported expression: Expr_AssignOp_Concat
	{
		mut iter_1 := this.pages.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page := item_1.val
			if rt.is_true(rt.new_bool(var_page.array_isset(rt.new_string('js_page')) && rt.is_true(var_page.array_get('js_page')))) {
				if rt.is_true(rt.identical(var_page.array_get('path'), var_current_path)) {
					this.current_page = var_page.dup()
					return rt.new_null()
				}
			} else {
				if rt.is_true(rt.new_bool(var_page.array_isset(rt.new_string('screen_id')) && rt.is_true(rt.identical(var_page.array_get('screen_id'), var_current_screen_id)))) {
					this.current_page = var_page.dup()
					return rt.new_null()
				}
			}
		}
	}
	this.current_page = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) get_breadcrumbs() rt.PhpVal {
	mut var_current_page := this.get_current_page()
	if rt.is_true(rt.identical(rt.new_bool(false), var_current_page)) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_get_breadcrumbs'), rt.create_array([rt.ArrayItem{ key: none, val: '' }]), var_current_page.dup()])
	}
	mut var_page_title := if !(!rt.is_true(var_current_page.array_get('page_title'))) { var_current_page.array_get('page_title') } else { var_current_page.array_get('title') }
	var_page_title = rt.cast_array(var_page_title)
	if 1 == var_page_title.dup().array_count() {
		mut var_breadcrumbs := var_page_title.dup()
	} else {
		var_breadcrumbs = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: none, val: var_current_page.array_get('path') }, rt.ArrayItem{ key: none, val: rt.call_function('reset', [var_page_title.dup()]) }]) }]), rt.call_function('array_slice', [var_page_title.dup(), rt.new_int(1)])])
	}
	if var_current_page.array_isset(rt.new_string('parent')) {
		mut var_parent_id := var_current_page.array_get('parent')
		for rt.is_true(var_parent_id) {
			if this.pages.array_isset(var_parent_id) {
				mut var_parent := this.pages.array_get(var_parent_id)
				if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_parent.array_get('path'), Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PageController.page_root()]))) {
					var_parent.array_set('path', 'admin.php?page=' + (var_parent.array_get('path')).str())
				}
				rt.call_function('array_unshift', [var_breadcrumbs.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_parent.array_get('path') }, rt.ArrayItem{ key: none, val: rt.call_function('reset', [var_parent.array_get('title')]) }])])
				var_parent_id = if var_parent.array_isset(rt.new_string('parent')) { var_parent.array_get('parent') } else { rt.new_bool(false) }
			} else {
				var_parent_id = rt.new_bool(rt.new_bool(false))
			}
		}
	}
	mut var_woocommerce_breadcrumb := rt.create_array([rt.ArrayItem{ key: none, val: 'admin.php?page=' + (Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PageController.page_root()).str() }, rt.ArrayItem{ key: none, val: rt.call_function('__', [rt.new_string('WooCommerce'), rt.new_string('woocommerce')]) }])
	rt.call_function('array_unshift', [var_breadcrumbs.dup(), var_woocommerce_breadcrumb.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_get_breadcrumbs'), var_breadcrumbs.dup(), var_current_page.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) get_current_page() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('current_screen')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('esc_html__', [rt.new_string('Current page retrieval should be called on or after the `current_screen` hook.'), rt.new_string('woocommerce')]), rt.new_string('0.16.0')])
	}
	if rt.is_true(rt.new_bool(this.current_page.is_null())) {
		this.determine_current_page()
	}
	return this.current_page
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) get_current_screen_id() rt.PhpVal {
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_current_screen_id'), rt.new_bool(false), rt.new_null()])
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_current_screen)))) {
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_current_screen_id'), rt.new_bool(false), var_current_screen.dup()])
	}
	mut var_screen_pieces := rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_current_screen, 'id') }])
	if rt.is_true(rt.get_property(var_current_screen, 'action')) {
		var_screen_pieces.array_push(rt.get_property(var_current_screen, 'action'))
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_current_screen, 'taxonomy'))) && !(rt.get_property(var_current_screen, 'post_type')).is_null() && rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_current_screen, 'post_type'))))) {
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_current_screen, 'taxonomy'), rt.new_string('pa_')]))) {
			var_screen_pieces = rt.create_array([rt.ArrayItem{ key: none, val: 'product_page_product_attribute-edit' }])
		}
		if !(!rt.is_true(rt.get_superglobal('_GET').array_get('tag_ID'))) {
			var_screen_pieces = rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_current_screen, 'taxonomy') }])
		}
	}
	mut var_pages_with_tabs := rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_pages_with_tabs'), rt.create_array([rt.ArrayItem{ key: 'wc-reports', val: 'orders' }, rt.ArrayItem{ key: 'wc-settings', val: 'general' }, rt.ArrayItem{ key: 'wc-status', val: 'status' }, rt.ArrayItem{ key: 'wc-addons', val: 'browse-extensions' }])])
	mut var_wc_emails := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_WC_Emails{}; return temp.instance() }()
	mut var_wc_email_ids := rt.call_function('array_map', [rt.new_string('sanitize_title'), rt.func_array_keys(rt.call_method(var_wc_emails, 'get_emails', []rt.PhpVal{}))])
	mut var_tabs_with_sections := rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_page_tab_sections'), rt.create_array([rt.ArrayItem{ key: 'products', val: rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'inventory' }, rt.ArrayItem{ key: none, val: 'downloadable' }, rt.ArrayItem{ key: none, val: 'download_urls' }, rt.ArrayItem{ key: none, val: 'advanced' }]) }, rt.ArrayItem{ key: 'shipping', val: rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'options' }, rt.ArrayItem{ key: none, val: 'classes' }, rt.ArrayItem{ key: none, val: 'pickup_location' }]) }, rt.ArrayItem{ key: 'checkout', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Gateway_BACS.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Cheque.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_COD.id() }, rt.ArrayItem{ key: none, val: Class_WC_Gateway_Paypal.id() }]) }, rt.ArrayItem{ key: 'email', val: var_wc_email_ids }, rt.ArrayItem{ key: 'advanced', val: rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: 'keys' }, rt.ArrayItem{ key: none, val: 'webhooks' }, rt.ArrayItem{ key: none, val: 'legacy_api' }, rt.ArrayItem{ key: none, val: 'woocommerce_com' }, rt.ArrayItem{ key: none, val: 'features' }, rt.ArrayItem{ key: none, val: 'blueprint' }]) }, rt.ArrayItem{ key: 'browse-extensions', val: rt.create_array([rt.ArrayItem{ key: none, val: 'helper' }]) }])])
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('page'))) {
		mut var_page := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('page')])])
		if rt.is_true(rt.call_function('in_array', [var_page.dup(), rt.func_array_keys(var_pages_with_tabs.dup())])) {
			if !(!rt.is_true(rt.get_superglobal('_GET').array_get('tab'))) {
				mut var_tab := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('tab')])])
			} else {
				var_tab = var_pages_with_tabs.array_get(var_page)
			}
			var_screen_pieces.array_push(var_tab.dup())
			if !(!rt.is_true(rt.get_superglobal('_GET').array_get('section'))) {
				mut var_section := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('section')])])
				if rt.is_true(rt.new_bool(var_tabs_with_sections.array_isset(var_tab) && rt.is_true(rt.call_function('in_array', [var_section.dup(), rt.call_function('array_values', [var_tabs_with_sections.array_get(var_tab)]), rt.new_bool(true)])))) {
					var_screen_pieces.array_push(var_section.dup())
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('shipping'), var_tab)) && rt.get_superglobal('_GET').array_isset(rt.new_string('zone_id')))) {
				var_screen_pieces.array_push('edit_zone')
			}
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_current_screen_id'), rt.call_function('implode', [rt.new_string('-'), var_screen_pieces.dup()]), var_current_screen.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) get_path_from_id(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	if this.pages.array_isset(var_id_mutated) && this.pages.array_get(var_id_mutated).array_isset(rt.new_string('path')) {
		return this.pages.array_get(var_id_mutated).array_get('path')
	}
	return var_id_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) is_connected_page() rt.PhpVal {
	mut var_current_page := this.get_current_page()
	if rt.is_true(rt.identical(rt.new_bool(false), var_current_page)) {
		mut var_is_connected_page := rt.new_bool(rt.new_bool(false))
	} else {
		var_is_connected_page = rt.new_bool(if var_current_page.array_isset(rt.new_string('js_page')) { rt.new_bool(!(rt.is_true(var_current_page.array_get('js_page')))) } else { rt.new_bool(true) })
	}
	mut var_current_screen := if rt.is_true(rt.call_function('did_action', [rt.new_string('current_screen')])) { rt.call_function('get_current_screen', []rt.PhpVal{}) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_current_screen)) && rt.is_true(rt.call_function('method_exists', [var_current_screen.dup(), rt.new_string('is_block_editor')])))) && rt.is_true(rt.call_method(var_current_screen, 'is_block_editor', []rt.PhpVal{})))) {
		var_is_connected_page = rt.new_bool(rt.new_bool(false))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_is_connected_page'), var_is_connected_page.dup(), var_current_page.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) is_registered_page() rt.PhpVal {
	mut var_current_page := this.get_current_page()
	if rt.is_true(rt.identical(rt.new_bool(false), var_current_page)) {
		mut var_is_registered_page := rt.new_bool(rt.new_bool(false))
	} else {
		var_is_registered_page = rt.new_bool(rt.new_bool(var_current_page.array_isset(rt.new_string('js_page')) && rt.is_true(var_current_page.array_get('js_page'))))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_navigation_is_registered_page'), var_is_registered_page.dup(), var_current_page.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) register_page(var_options rt.PhpVal)  {
	mut var_options_mutated := var_options
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_null() }, rt.ArrayItem{ key: 'parent', val: rt.new_null() }, rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'page_title', val: '' }, rt.ArrayItem{ key: 'capability', val: 'view_woocommerce_reports' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'icon', val: '' }, rt.ArrayItem{ key: 'position', val: rt.new_null() }, rt.ArrayItem{ key: 'js_page', val: true }])
	var_options_mutated = rt.call_function('wp_parse_args', [var_options_mutated.dup(), var_defaults.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_options_mutated.array_set('path', (Class_Automattic_WooCommerce_Admin_Automattic_WooCommerce_Admin_PageController.page_root()).str() + '&path=' + (var_options_mutated.array_get('path')).str())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_options_mutated.array_set('position', rt.call_function('round', [var_options_mutated.array_get('position')]).to_i64())
	}
	if !rt.is_true(var_options_mutated.array_get('page_title')) {
		var_options_mutated.array_set('page_title', var_options_mutated.array_get('title'))
	}
	if rt.is_true(rt.new_bool(var_options_mutated.array_get('parent').is_null())) {
		rt.call_function('add_menu_page', [var_options_mutated.array_get('page_title'), var_options_mutated.array_get('title'), var_options_mutated.array_get('capability'), var_options_mutated.array_get('path'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'page_wrapper' }]), var_options_mutated.array_get('icon'), var_options_mutated.array_get('position')])
	} else {
		mut var_parent_path := this.get_path_from_id(var_options_mutated.array_get('parent'))
		rt.call_function('add_submenu_page', [var_parent_path.dup(), var_options_mutated.array_get('page_title'), var_options_mutated.array_get('title'), var_options_mutated.array_get('capability'), var_options_mutated.array_get('path'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'page_wrapper' }])])
	}
	this.connect_page(var_options_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) get_pages() rt.PhpVal {
	return this.pages
}

fn Class_Automattic_WooCommerce_Admin_PageController.page_wrapper()  {
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Loader{}; return temp.page_wrapper() }()
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) register_page_handler()  {
	rt.include_file((rt.get_constant('WC_ADMIN_ABSPATH')).str() + 'includes/react-admin/connect-existing-pages.php', '4')
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) register_store_details_page()  {
	rt.call_function('wc_admin_register_page', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup-wizard' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Setup Wizard'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'parent', val: '' }, rt.ArrayItem{ key: 'path', val: '/setup-wizard' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) remove_app_entry_page_menu_item()  {
	mut var_submenu := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', []))))) || !rt.is_true(var_submenu.array_get('woocommerce')))) {
		return rt.new_null()
	}
	mut var_wc_admin_key := rt.new_null()
	{
		mut iter_1 := .array_get().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_submenu_item := item_1.val
			mut var_submenu_key := item_1.key
			if rt.is_true() {
			}
		}
	}
	if rt.is_true() {
	}
	.array_unset()
}

fn Class_Automattic_WooCommerce_Admin_PageController.is_admin_or_embed_page() bool {
}

fn Class_Automattic_WooCommerce_Admin_PageController.is_admin_page() bool {
	return false
}

fn Class_Automattic_WooCommerce_Admin_PageController.is_settings_page() bool {
	return false
}

fn Class_Automattic_WooCommerce_Admin_PageController.is_embed_page() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Admin_PageController.is_modern_settings_page() bool {
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) maybe_redirect_payment_tasks_to_settings()  {
}

struct Class_Automattic_WooCommerce_Admin_WC_Emails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Loader {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_pagecontroller() &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_bool(false)
		current_page: rt.new_null()
		pages: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_wc_emails() &Class_Automattic_WooCommerce_Admin_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Admin_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_loader() &Class_Automattic_WooCommerce_Internal_Admin_Loader {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_PageController.get_instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'connect_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.connect_page(dispatch_arg_0)
			return rt.new_null()
		}
		'determine_current_page' {
			this.determine_current_page()
			return rt.new_null()
		}
		'get_breadcrumbs' {
			return this.get_breadcrumbs()
		}
		'get_current_page' {
			return this.get_current_page()
		}
		'get_current_screen_id' {
			return this.get_current_screen_id()
		}
		'get_path_from_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_path_from_id(dispatch_arg_0)
		}
		'is_connected_page' {
			return this.is_connected_page()
		}
		'is_registered_page' {
			return this.is_registered_page()
		}
		'register_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_page(dispatch_arg_0)
			return rt.new_null()
		}
		'get_pages' {
			return this.get_pages()
		}
		'page_wrapper' {
			Class_Automattic_WooCommerce_Admin_PageController.page_wrapper()
			return rt.new_null()
		}
		'register_page_handler' {
			this.register_page_handler()
			return rt.new_null()
		}
		'register_store_details_page' {
			this.register_store_details_page()
			return rt.new_null()
		}
		'remove_app_entry_page_menu_item' {
			this.remove_app_entry_page_menu_item()
			return rt.new_null()
		}
		'is_admin_or_embed_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PageController.is_admin_or_embed_page())
		}
		'is_admin_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PageController.is_admin_page())
		}
		'is_settings_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PageController.is_settings_page())
		}
		'is_embed_page' {
			return Class_Automattic_WooCommerce_Admin_PageController.is_embed_page()
		}
		'is_modern_settings_page' {
			return rt.new_bool(Class_Automattic_WooCommerce_Admin_PageController.is_modern_settings_page())
		}
		'maybe_redirect_payment_tasks_to_settings' {
			this.maybe_redirect_payment_tasks_to_settings()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_PageController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'current_page' { return this.current_page }
		'pages' { return this.pages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_PageController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'current_page' { this.current_page = val; return true }
		'pages' { this.pages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_pagecontroller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
