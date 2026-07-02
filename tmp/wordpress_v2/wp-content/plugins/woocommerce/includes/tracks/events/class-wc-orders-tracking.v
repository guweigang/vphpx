import rt

struct Class_WC_Orders_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Orders_Tracking) init() {
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_changed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_order_status_change' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_order_action' },
		]),
		rt.new_int(51)])
	rt.call_function('add_action', [rt.new_string('load-edit.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_orders_view' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-orders'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_orders_view' },
		]),
		rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('load-post-new.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_add_order_from_edit' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-orders'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_add_order_from_edit' },
		]),
		rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('woocommerce_process_shop_order_meta'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_created_date_change' },
		]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('load-edit.php'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_search_in_orders_list' },
		])])
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-orders'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_search_in_orders_list' },
		]),
		rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Orders_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'possibly_add_order_tracking_scripts' },
		])])
}

fn (mut this Class_WC_Orders_Tracking) track_order_search(var_order_ids rt.PhpVal, var_term rt.PhpVal, var_search_fields rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('8.6.0'), rt.new_string('WC_Orders_Tracking::track_search_in_orders_list')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_current_screen'),
	])))))
	{
		return var_order_ids.clone()
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('edit-shop_order'), rt.get_property(var_screen, 'id'))) {
		mut iife_temp_0 := Class_WC_Tracks{}
		mut iife_result_0 := iife_temp_0.record_event(rt.new_string('orders_view_search'))
	}
	return var_order_ids.clone()
}

fn (mut this Class_WC_Orders_Tracking) track_search_in_orders_list() {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_1 := iife_temp_1.is_order_list_table_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))) {
		return
	}
	mut iife_temp_2 := Class_WC_Tracks{}
	mut iife_result_2 := iife_temp_2.record_event(rt.new_string('orders_view_search'))
}

fn (mut this Class_WC_Orders_Tracking) track_orders_view() {
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_3 := iife_temp_3.is_order_list_table_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return
	}
	mut var_properties := {
		'status': rt.call_function('sanitize_text_field', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('post_status'))).is_null() {
			rt.get_superglobal('_GET').array_get(rt.new_string('post_status'))
		} else {
			if !(rt.get_superglobal('_GET').array_get(rt.new_string('status'))).is_null() {
				rt.get_superglobal('_GET').array_get(rt.new_string('status'))
			} else {
				rt.new_string('all')
			}
		}])
	}
	mut iife_temp_4 := Class_WC_Tracks{}
	mut iife_result_4 := iife_temp_4.record_event(rt.new_string('orders_view'),
		var_properties.clone())
}

fn (mut this Class_WC_Orders_Tracking) track_order_status_change(var_id rt.PhpVal, var_previous_status rt.PhpVal, var_next_status rt.PhpVal) {
	mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
	mut var_properties := {
		'order_id':        var_id
		'next_status':     var_next_status
		'previous_status': var_previous_status
		'date_created':    if rt.is_true(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'date', [
				rt.new_string('Y-m-d'),
			]) } else { rt.new_string('') }
		'payment_method':  rt.call_method(var_order, 'get_payment_method', []rt.PhpVal{})
		'order_total':     rt.call_method(var_order, 'get_total', []rt.PhpVal{})
	}
	mut iife_temp_5 := Class_WC_Tracks{}
	mut iife_result_5 := iife_temp_5.record_event(rt.new_string('orders_edit_status_change'),
		var_properties.clone())
}

fn (mut this Class_WC_Orders_Tracking) track_created_date_change(var_id rt.PhpVal) {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_6 := iife_temp_6.is_order(var_id.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_6)))) {
		return
	}
	mut var_order := rt.call_function('wc_get_order', [var_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft(), rt.call_method(var_order, 'get_status', []rt.PhpVal{}))) {
		return
	}
	mut var_date_created := if rt.is_true(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})) { rt.call_method(rt.call_method(var_order, 'get_date_created', []rt.PhpVal{}), 'date', [
			rt.new_string('Y-m-d H:i:s'),
		]) } else { rt.new_string('') }
	mut var_new_date := rt.call_function('sprintf', [rt.new_string('%s %2d:%02d:%02d'),
		if rt.get_superglobal('_POST').array_isset(rt.new_string('order_date')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('order_date')),
				]),
			]) } else { rt.new_string('') }, if rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_hour')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('order_date_hour')),
				]),
			]) } else { rt.new_string('') }, if rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_minute')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('order_date_minute')),
				]),
			]) } else { rt.new_string('') }, if rt.get_superglobal('_POST').array_isset(rt.new_string('order_date_second')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('order_date_second')),
				]),
			]) } else { rt.new_string('') }])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_new_date, var_date_created)))) {
		mut var_properties := {
			'order_id': var_id
			'status':   rt.call_method(var_order, 'get_status', []rt.PhpVal{})
		}
		mut iife_temp_7 := Class_WC_Tracks{}
		mut iife_result_7 := iife_temp_7.record_event(rt.new_string('order_edit_date_created'),
			var_properties.clone())
	}
}

fn (mut this Class_WC_Orders_Tracking) track_order_action(var_order_id rt.PhpVal) {
	mut var_order_id_mutated := var_order_id
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('wc_order_action')))) {
		mut var_order := rt.call_function('wc_get_order', [var_order_id_mutated.clone()])
		mut var_action := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('wc_order_action')),
			]),
		])
		mut var_properties := {
			'order_id': var_order_id_mutated
			'status':   rt.call_method(var_order, 'get_status', []rt.PhpVal{})
			'action':   var_action
		}
		mut iife_temp_8 := Class_WC_Tracks{}
		mut iife_result_8 := iife_temp_8.record_event(rt.new_string('order_edit_order_action'),
			var_properties.clone())
	}
}

fn (mut this Class_WC_Orders_Tracking) track_add_order_from_edit() {
	mut var_referring_args := map[string]rt.PhpVal{}
	mut iife_temp_9 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_9 := iife_temp_9.is_new_order_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_9)))) {
		return
	}
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_referer)))) {
		return
	}
	mut var_referring_page := rt.call_function('wp_parse_url', [
		var_referer.clone()])
	if !rt.is_true(var_referring_page.array_get(rt.new_string('query'))) {
		return
	}
	rt.call_function('parse_str', [var_referring_page.array_get(rt.new_string('query')),
		rt.create_array_from_native_map(var_referring_args)])
	mut iife_temp_10 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_10 := iife_temp_10.custom_orders_table_usage_is_enabled()
	if rt.is_true(iife_result_10) {
		mut var_post_edit_page := rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-orders'),
		])
		mut var_order_id := if !(var_referring_args.array_get(rt.new_string('id'))).is_null() {
			var_referring_args.array_get(rt.new_string('id'))
		} else {
			rt.new_int(0)
		}
	} else {
		var_post_edit_page = rt.call_function('admin_url', [rt.new_string('post.php')])
		var_order_id = if !(var_referring_args.array_get(rt.new_string('post'))).is_null() {
			var_referring_args.array_get(rt.new_string('post'))
		} else {
			rt.new_int(0)
		}
	}
	var_post_edit_page = rt.call_function('wp_parse_url', [var_post_edit_page.clone()])
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_11 := iife_temp_11.get_order_type(var_order_id.clone())
	if rt.is_true(rt.identical(var_post_edit_page.array_get(rt.new_string('path')), var_referring_page.array_get(rt.new_string('path'))))
		&& !(var_post_edit_page.array_isset(rt.new_string('query')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_referring_page.array_get(rt.new_string('query')), var_post_edit_page.array_get(rt.new_string('query'))])))))
		&& var_referring_args.array_isset(rt.new_string('action'))
		&& rt.is_true(rt.identical(rt.new_string('edit'), var_referring_args.array_get(rt.new_string('action'))))
		&& rt.is_true(rt.identical(rt.new_string('shop_order'), iife_result_11)) {
		mut iife_temp_12 := Class_WC_Tracks{}
		mut iife_result_12 := iife_temp_12.record_event(rt.new_string('order_edit_add_order'))
	}
}

fn (mut this Class_WC_Orders_Tracking) possibly_add_order_tracking_scripts() {
	mut iife_temp_13 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_13 := iife_temp_13.is_new_order_screen()
	mut iife_temp_14 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_14 := iife_temp_14.is_order_edit_screen()
	mut iife_temp_15 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_15 := iife_temp_15.is_order_list_table_screen()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_13))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_14))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_15)))) {
		return
	}
	mut iife_temp_16 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_16 := iife_temp_16.register_script(rt.new_string('wp-admin-scripts'),
		rt.new_string('order-tracking'), rt.new_bool(false))
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_wc_orders_tracking(_args ...rt.PhpVal) &Class_WC_Orders_Tracking {
	mut obj := &Class_WC_Orders_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
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

fn (mut this Class_WC_Orders_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_order_search' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.track_order_search(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'track_search_in_orders_list' {
			this.track_search_in_orders_list()
			return rt.new_null()
		}
		'track_orders_view' {
			this.track_orders_view()
			return rt.new_null()
		}
		'track_order_status_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.track_order_status_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'track_created_date_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_created_date_change(dispatch_arg_0)
			return rt.new_null()
		}
		'track_order_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.track_order_action(dispatch_arg_0)
			return rt.new_null()
		}
		'track_add_order_from_edit' {
			this.track_add_order_from_edit()
			return rt.new_null()
		}
		'possibly_add_order_tracking_scripts' {
			this.possibly_add_order_tracking_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Orders_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Orders_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
