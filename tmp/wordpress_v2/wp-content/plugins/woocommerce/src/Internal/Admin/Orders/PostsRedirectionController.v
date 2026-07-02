import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController {
	rt.PhpObjectBase
pub mut:
	page_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) construct(mut var_page_controller Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController) {
	this.page_controller = var_page_controller
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
	]), 'custom_orders_table_usage_is_enabled', []rt.PhpVal{})))))
	{
		return
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.maybe_update_menu_items()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.new_closure(closure_1_fn), rt.new_int(9999)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.maybe_redirect_to_orders_page()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('load-edit.php'),
		rt.new_closure(closure_2_fn)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.maybe_redirect_to_new_order_page()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('load-post-new.php'),
		rt.new_closure(closure_3_fn)])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.maybe_redirect_to_edit_order_page()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('load-post.php'),
		rt.new_closure(closure_4_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) maybe_redirect_to_orders_page() {
	mut var_post_type := if !(rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')]), rt.new_bool(true)]))))) {
		return
	}
	mut var_query_args := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').clone()])
	mut var_action := if !(var_query_args.array_get(rt.new_string('action'))).is_null() {
		var_query_args.array_get(rt.new_string('action'))
	} else {
		rt.new_string('')
	}
	mut var_posts := if !(var_query_args.array_get(rt.new_string('post'))).is_null() {
		var_query_args.array_get(rt.new_string('post'))
	} else {
		rt.new_array()
	}
	var_query_args.array_unset(rt.new_string('post_type'))
	var_query_args.array_unset(rt.new_string('post'))
	var_query_args.array_unset(rt.new_string('_wpnonce'))
	var_query_args.array_unset(rt.new_string('_wp_http_referer'))
	var_query_args.array_unset(rt.new_string('action'))
	if var_query_args.array_isset(rt.new_string('post_status')) {
		var_query_args.array_set('status', var_query_args.array_get(rt.new_string('post_status')))
		var_query_args.array_unset(rt.new_string('post_status'))
	}
	mut var_new_url := rt.call_method(this.page_controller, 'get_base_page_url', [
		var_post_type.clone(),
	])
	var_new_url = rt.call_function('add_query_arg', [var_query_args.clone(),
		var_new_url.clone()])
	if rt.is_true(var_action)
		&& rt.is_true(rt.call_function('in_array', [var_action.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'trash'
	}, rt.ArrayItem{ key: none, val: 'untrash' }, rt.ArrayItem{ key: none, val: 'delete' }, rt.ArrayItem{
		key: none
		val: 'mark_processing'
	}, rt.ArrayItem{ key: none, val: 'mark_on-hold' }, rt.ArrayItem{
		key: none
		val: 'mark_completed'
	}, rt.ArrayItem{ key: none, val: 'mark_cancelled' }]), rt.new_bool(true)])) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-posts')])
		var_new_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: var_action },
				rt.ArrayItem{ key: 'id', val: var_posts }, rt.ArrayItem{ key: '_wp_http_referer', val: rt.call_method(this.page_controller,
					'get_orders_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('bulk-orders'),
				]) }]),
			var_new_url.clone(),
		])
	}
	rt.call_function('wp_safe_redirect', [var_new_url.clone(),
		rt.new_int(301)])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) maybe_redirect_to_new_order_page() {
	mut var_post_type := if !(rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')]), rt.new_bool(true)]))))) {
		return
	}
	mut var_query_args := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').clone()])
	var_query_args.array_unset(rt.new_string('post_type'))
	mut var_new_url := rt.call_method(this.page_controller, 'get_new_page_url', [
		var_post_type.clone(),
	])
	var_new_url = rt.call_function('add_query_arg', [var_query_args.clone(),
		var_new_url.clone()])
	rt.call_function('wp_safe_redirect', [var_new_url.clone(),
		rt.new_int(301)])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) maybe_redirect_to_edit_order_page() {
	mut var_post_id := rt.call_function('absint', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('post'))).is_null() {
		rt.get_superglobal('_GET').array_get(rt.new_string('post'))
	} else {
		rt.new_int(0)
	}])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return
	}
	mut var_redirect_from_types := rt.call_function('wc_get_order_types', [
		rt.new_string('admin-menu'),
	])
	var_redirect_from_types.array_push('shop_order_placehold')
	mut var_post_type := rt.call_function('get_post_type', [var_post_id.clone()])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_4 := iife_temp_4.get_order_type(var_post_id.clone())
	mut var_order_type := if rt.is_true(var_post_type) { var_post_type } else { iife_result_4 }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_order_type.clone(), var_redirect_from_types.clone(), rt.new_bool(true)])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('action'))) {
		return
	}
	mut var_query_args := rt.call_function('wp_unslash', [rt.get_superglobal('_GET').clone()])
	mut var_action := var_query_args.array_get(rt.new_string('action'))
	var_query_args.array_unset(rt.new_string('post'))
	var_query_args.array_unset(rt.new_string('_wpnonce'))
	var_query_args.array_unset(rt.new_string('_wp_http_referer'))
	var_query_args.array_unset(rt.new_string('action'))
	mut var_new_url := rt.new_string('')
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		var_new_url = rt.call_method(this.page_controller, 'get_edit_url', [
			var_post_id.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('trash')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('untrash')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('delete'))) {
		rt.call_function('check_admin_referer', [
			rt.new_string(var_action.str() + '-post_' + var_post_id.str()),
		])
		var_new_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: var_action },
				rt.ArrayItem{ key: 'order', val: rt.create_array([
					rt.ArrayItem{ key: none, val: var_post_id },
				]) }, rt.ArrayItem{ key: '_wp_http_referer', val: rt.call_method(this.page_controller,
					'get_orders_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
					rt.new_string('bulk-orders'),
				]) }]),
			rt.call_method(this.page_controller, 'get_orders_url', []rt.PhpVal{}),
		])
	} else {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_new_url)))) {
		return
	}
	var_new_url = rt.call_function('add_query_arg', [var_query_args.clone(),
		var_new_url.clone()])
	rt.call_function('wp_safe_redirect', [var_new_url.clone(),
		rt.new_int(301)])
	exit(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) maybe_update_menu_items() {
	mut var_pagenow := rt.new_null()
	mut var_submenu := rt.new_null()
	mut var_post_type_menu := rt.new_null()
	mut var_x := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('edit.php'), var_pagenow))
		&& rt.is_true(rt.call_function('in_array', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('post_type'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('post_type')) } else { rt.new_string('') }, rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')]), rt.new_bool(true)])) {
		return
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{}
	mut iife_result_5 := iife_temp_5.can_view_woocommerce_menu_item()
	if rt.is_true(iife_result_5) {
		return
	}
	mut var_post_types := rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('get_post_type_object'),
			rt.call_function('wc_get_order_types', [rt.new_string('admin-menu')])]),
	])
	mut iter_1 := var_post_types.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_type := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])))))
			|| !(var_submenu.array_isset('edit.php?post_type=' + (rt.get_property(var_post_type, 'name')).str())) {
			continue
		}
		var_post_type_menu = var_submenu.array_get(rt.new_string('edit.php?post_type=' +
			(rt.get_property(var_post_type, 'name')).str()))
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_x := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_x.array_get(rt.new_int(2))
		}
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_x := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_x.array_get(rt.new_int(2))
		}
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_x := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_x.array_get(rt.new_int(2))
		}
		closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_x := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return var_x.array_get(rt.new_int(2))
		}
		mut var_menu_indexes := rt.call_function('array_flip', [
			rt.call_function('array_map', [rt.new_closure(closure_7_fn),
				var_post_type_menu.clone()]),
		])
		var_post_type_menu.array_get_mut(var_menu_indexes.array_get(rt.new_string(
			'edit.php?post_type=' + (rt.get_property(var_post_type, 'name')).str()))).array_set(2, rt.call_method(this.page_controller,
			'get_base_page_url', [rt.get_property(var_post_type, 'name')]))
		var_post_type_menu.array_unset(var_menu_indexes.array_get(rt.new_string((rt.concat(rt.new_string('post-new.php?post_type='), rt.get_property(var_post_type,
			'name'))).str())))
	}
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_orders_postsredirectioncontroller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController{
		PhpObjectBase:   rt.PhpObjectBase{}
		page_controller: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_orders_wc_admin_menus(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_PageController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_redirect_to_orders_page' {
			this.maybe_redirect_to_orders_page()
			return rt.new_null()
		}
		'maybe_redirect_to_new_order_page' {
			this.maybe_redirect_to_new_order_page()
			return rt.new_null()
		}
		'maybe_redirect_to_edit_order_page' {
			this.maybe_redirect_to_edit_order_page()
			return rt.new_null()
		}
		'maybe_update_menu_items' {
			this.maybe_update_menu_items()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'page_controller' { return this.page_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_PostsRedirectionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'page_controller' {
			this.page_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_WC_Admin_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
