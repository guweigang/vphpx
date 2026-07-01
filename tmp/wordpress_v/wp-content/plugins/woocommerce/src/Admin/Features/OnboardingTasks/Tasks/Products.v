import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_product_transient() string {
	return 'woocommerce_product_task_has_product_transient'
}
struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products {
	rt.PhpObjectBase
pub mut:
		revert_scheduled rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) construct(var_task_list rt.PhpVal)  {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.dup())
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_import_return_notice_script' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'possibly_add_load_sample_return_notice_script' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_update_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_has_product_transient' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_new_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_has_product_transient' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('untrashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_set_has_product_transient_on_untrashed_post' }])])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_redirect_to_add_product_tasklist' }]), rt.new_int(30), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('trashed_post'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'on_product_trashed' }])])
	rt.call_function('add_action', [rt.new_string('deleted_post_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'on_product_deleted' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) get_id() string {
	return 'products'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) get_title() rt.PhpVal {
	mut var_onboarding_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	if rt.is_true(rt.new_bool(var_onboarding_profile.array_isset(rt.new_string('business_choice')) && rt.is_true(rt.identical(rt.new_string('im_already_selling'), var_onboarding_profile.array_get('business_choice'))))) {
		return rt.call_function('__', [rt.new_string('Import your products'), rt.new_string('woocommerce')])
	}
	return rt.call_function('__', [rt.new_string('Add your products'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) get_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Start by adding the first product to your store. You can add your products manually, via CSV, or import them from another service.'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) get_time() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('1 minute per product'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) is_complete() bool {
	if rt.is_true(this.has_previously_completed()) {
		return true
	}
	return (Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_products()).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) get_additional_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'has_products', val: Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_products() }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) is_always_accessible() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) possibly_add_import_return_notice_script(var_hook rt.PhpVal)  {
	mut var_step := if rt.get_superglobal('_GET').array_isset(rt.new_string('step')) { rt.get_superglobal('_GET').array_get('step') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.is_active())))) || this.is_complete())) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('onboarding-product-import-notice'), rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) possibly_add_load_sample_return_notice_script(var_hook rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_referer)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	if !(rt.get_superglobal('_GET').array_isset(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient())) {
		return rt.new_null()
	}
	mut var_task_id := rt.call_function('sanitize_title_with_dashes', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.active_task_transient())])])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(this.is_complete()))) {
		return rt.new_null()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}; return temp.register_script(arg_0, arg_1, arg_2) }(rt.new_string('wp-admin-scripts'), rt.new_string('onboarding-load-sample-products-notice'), rt.new_bool(true))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) maybe_set_has_product_transient_on_untrashed_post(var_post_id rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	this.maybe_set_has_product_transient(var_post_id.dup(), rt.call_function('wc_get_product', [var_post_id.dup()]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) maybe_set_has_product_transient(var_product_id rt.PhpVal, var_product rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.has_previously_completed())))) && this.is_valid_product(var_product.dup()))) {
		rt.call_function('set_transient', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_product_transient(), rt.new_string('yes')])
		this.possibly_track_completion()
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) on_product_trashed(var_post_id rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	this.revert_task_completion()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) on_product_deleted()  {
	this.revert_task_completion()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) revert_task_completion()  {
	rt.call_function('delete_transient', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_product_transient()])
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		return rt.new_null()
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products', ['Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task'], &this) }, rt.ArrayItem{ key: none, val: 'maybe_revert_on_shutdown' }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) maybe_revert_on_shutdown()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_products()) {
		return rt.new_null()
	}
	mut var_completed_tasks := rt.call_function('get_option', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.completed_option(), rt.new_array()])
	mut var_task_id := rt.new_string(this.get_id())
	if rt.is_true(rt.call_function('in_array', [var_task_id.dup(), var_completed_tasks.dup(), rt.new_bool(true)])) {
		var_completed_tasks = rt.call_function('array_values', [rt.call_function('array_diff', [var_completed_tasks.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_task_id }])])])
		rt.call_function('update_option', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.completed_option(), var_completed_tasks.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) is_valid_product(var_product rt.PhpVal) bool {
	return rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.call_method(var_product, 'get_status', []rt.PhpVal{}))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'get_meta', [rt.new_string('_headstart_post')]))))) || rt.is_true(rt.call_function('get_post_meta', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), rt.new_string('_edit_last'), rt.new_bool(true)]))))
}

fn Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_products() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_exists := rt.call_function('get_transient', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_product_transient()])
	if rt.is_true(var_product_exists) {
		return rt.identical(rt.new_string('yes'), var_product_exists)
	}
	// unsupported statement: Stmt_Global
	mut var_value := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT IF(\n\t\t\t\t\tEXISTS (\n\t\t\t\t\t\tSELECT 1 FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p\n\t\t\t\t\t\tWHERE p.post_type = %s\n\t\t\t\t\t\tAND p.post_status = %s\n\t\t\t\t\t\tAND (\n\t\t\t\t\t\t\tEXISTS (\n\t\t\t\t\t\t\t\tSELECT 1 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n\t\t\t\t\t\t\t\tWHERE pm.post_id = p.ID\n\t\t\t\t\t\t\t\tAND pm.meta_key = %s\n\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\tOR\n\t\t\t\t\t\t\tNOT EXISTS (\n\t\t\t\t\t\t\t\tSELECT 1 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n\t\t\t\t\t\t\t\tWHERE pm.post_id = p.ID\n\t\t\t\t\t\t\t\tAND pm.meta_key = %s\n\t\t\t\t\t\t\t)\n\t\t\t\t\t\t\tOR\n\t\t\t\t\t\t\tEXISTS (\n\t\t\t\t\t\t\t\tSELECT 1 FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm\n\t\t\t\t\t\t\t\tWHERE pm.post_id = p.ID\n\t\t\t\t\t\t\t\tAND pm.meta_key = %s\n\t\t\t\t\t\t\t\tAND pm.meta_value = \'\'\n\t\t\t\t\t\t\t)\n\t\t\t\t\t\t)\n\t\t\t\t\t\tLIMIT 1\n\t\t\t\t\t),\n\t\t\t\t\t\'yes\', \'no\'\n\t\t\t\t)')), rt.new_string('product'), Class_Automattic_WooCommerce_Enums_ProductStatus.publish(), rt.new_string('_edit_last'), rt.new_string('_headstart_post'), rt.new_string('_headstart_post')])])
	rt.call_function('set_transient', [Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_product_transient(), var_value.dup()])
	return rt.identical(rt.new_string('yes'), var_value)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) maybe_redirect_to_add_product_tasklist()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_screen) && rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_screen, 'base'))))) && rt.is_true(rt.identical(rt.new_string('product'), rt.get_property(var_screen, 'post_type'))))) {
		mut var_counts := rt.cast_array(rt.call_function('wp_count_posts', [rt.get_property(var_screen, 'post_type')]))
		var_counts.array_unset(rt.new_string('auto-draft'))
		mut var_count := rt.call_function('array_sum', [var_counts.dup()])
		if rt.is_true(rt.greater(var_count, rt.new_int(0))) {
			return rt.new_null()
		}
		rt.call_function('wp_safe_redirect', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-admin&task=products')])])
		// unsupported expression: Expr_Exit
	}
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_products(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products{
		PhpObjectBase: rt.PhpObjectBase{}
		revert_scheduled: rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return this.get_content()
		}
		'get_time' {
			return this.get_time()
		}
		'is_complete' {
			return rt.new_bool(this.is_complete())
		}
		'get_additional_data' {
			return this.get_additional_data()
		}
		'is_always_accessible' {
			return rt.new_bool(this.is_always_accessible())
		}
		'possibly_add_import_return_notice_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_import_return_notice_script(dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_add_load_sample_return_notice_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.possibly_add_load_sample_return_notice_script(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_set_has_product_transient_on_untrashed_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_set_has_product_transient_on_untrashed_post(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_set_has_product_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.maybe_set_has_product_transient(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'on_product_trashed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_product_trashed(dispatch_arg_0)
			return rt.new_null()
		}
		'on_product_deleted' {
			this.on_product_deleted()
			return rt.new_null()
		}
		'revert_task_completion' {
			this.revert_task_completion()
			return rt.new_null()
		}
		'maybe_revert_on_shutdown' {
			this.maybe_revert_on_shutdown()
			return rt.new_null()
		}
		'is_valid_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_product(dispatch_arg_0))
		}
		'has_products' {
			return Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products.has_products()
		}
		'maybe_redirect_to_add_product_tasklist' {
			this.maybe_redirect_to_add_product_tasklist()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'revert_scheduled' { return this.revert_scheduled }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'revert_scheduled' { this.revert_scheduled = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_products_php() {
}
