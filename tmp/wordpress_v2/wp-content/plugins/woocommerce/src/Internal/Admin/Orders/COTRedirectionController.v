import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController) setup() {
	rt.call_function('add_action', [rt.new_string('admin_page_access_denied'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_hpos_admin_requests' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController) handle_hpos_admin_requests(var_query_params rt.PhpVal) {
	mut var_query_params_mutated := var_query_params
	var_query_params_mutated = if var_query_params_mutated.clone().is_array() {
		var_query_params_mutated
	} else {
		rt.get_superglobal('_GET')
	}
	if !(var_query_params_mutated.array_isset(rt.new_string('page')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wc-orders'), var_query_params_mutated.array_get(rt.new_string('page')))))) {
		return
	}
	mut var_params := rt.call_function('wp_unslash', [var_query_params_mutated.clone()])
	mut var_action := if !(var_params.array_get(rt.new_string('action'))).is_null() {
		var_params.array_get(rt.new_string('action'))
	} else {
		rt.new_string('')
	}
	var_params.array_unset(rt.new_string('page'))
	if rt.is_true(rt.identical(rt.new_string('edit'), var_action))
		&& var_params.array_isset(rt.new_string('id')) {
		var_params.array_set('post', var_params.array_get(rt.new_string('id')))
		var_params.array_unset(rt.new_string('id'))
		mut var_new_url := rt.call_function('add_query_arg', [
			var_params.clone(),
			rt.call_function('get_admin_url', [
				rt.new_null(), rt.new_string('post.php')])])
	} else if rt.is_true(rt.identical(rt.new_string('new'), var_action)) {
		var_params.array_unset(rt.new_string('action'))
		var_params.array_set('post_type', 'shop_order')
		var_new_url = rt.call_function('add_query_arg', [var_params.clone(),
			rt.call_function('get_admin_url', [rt.new_null(),
				rt.new_string('post-new.php')])])
	} else {
		if var_params.array_isset(rt.new_string('_wpnonce'))
			&& rt.is_true(rt.call_function('check_admin_referer', [rt.new_string('bulk-orders')])) {
			var_params.array_set('_wp_http_referer', rt.call_function('get_admin_url', [
				rt.new_null(),
				rt.new_string('edit.php?post_type=shop_order'),
			]))
			var_params.array_set('_wpnonce', rt.call_function('wp_create_nonce', [
				rt.new_string('bulk-posts'),
			]))
		}
		if var_params.array_isset(rt.new_string('id'))
			&& var_params.array_get(rt.new_string('id')).is_array() {
			var_params.array_set('post', var_params.array_get(rt.new_string('id')))
			var_params.array_unset(rt.new_string('id'))
		}
		var_params.array_set('post_type', 'shop_order')
		var_new_url = rt.call_function('add_query_arg', [var_params.clone(),
			rt.call_function('get_admin_url', [rt.new_null(),
				rt.new_string('edit.php')])])
	}
	if !(!rt.is_true(var_new_url))
		&& rt.is_true(rt.call_function('wp_safe_redirect', [var_new_url.clone(), rt.new_int(301)])) {
		exit(0)
	}
}

fn create_automattic_woocommerce_internal_admin_orders_cotredirectioncontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'setup' {
			this.setup()
			return rt.new_null()
		}
		'handle_hpos_admin_requests' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.handle_hpos_admin_requests(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_COTRedirectionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
