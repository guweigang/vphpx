import rt

pub fn Class_WC_Product_Usage_Notice.dismissed_count_meta_prefix() string {
	return '_woocommerce_product_usage_notice_dismissed_count_'
}
pub fn Class_WC_Product_Usage_Notice.dismissed_timestamp_meta_prefix() string {
	return '_woocommerce_product_usage_notice_dismissed_timestamp_'
}
pub fn Class_WC_Product_Usage_Notice.remind_later_timestamp_meta_prefix() string {
	return '_woocommerce_product_usage_notice_remind_later_timestamp_'
}
pub fn Class_WC_Product_Usage_Notice.last_dismissed_timestamp_meta() string {
	return '_woocommerce_product_usage_notice_last_dismissed_timestamp'
}
struct Class_WC_Product_Usage_Notice {
	rt.PhpObjectBase
}

fn init_static_wc_product_usage_notice() {
		rt.init_static_prop('WC_Product_Usage_Notice', 'product_usage_notice_rules', rt.new_array())
		rt.init_static_prop('WC_Product_Usage_Notice', 'current_notice_rule', rt.new_array())
}

fn Class_WC_Product_Usage_Notice.load() {
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_show_product_usage_notice' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_woocommerce_dismiss_product_usage_notice'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'ajax_dismiss' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_woocommerce_remind_later_product_usage_notice'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'ajax_remind_later' }])])
}

fn Class_WC_Product_Usage_Notice.maybe_show_product_usage_notice(var_screen rt.PhpVal) {
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		return
	}
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.is_site_connected()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	mut iife_temp_1 := Class_WC_Helper{}
	mut iife_result_1 := iife_temp_1.get_product_usage_notice_rules()
	rt.set_static_prop('WC_Product_Usage_Notice', 'product_usage_notice_rules', iife_result_1)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if !rt.is_true(rt.get_static_prop('WC_Product_Usage_Notice', 'product_usage_notice_rules')) {
		return
	}
	rt.set_static_prop('WC_Product_Usage_Notice', 'current_notice_rule', Class_WC_Product_Usage_Notice.get_current_notice_rule(var_screen.clone()))
	if !rt.is_true(rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule')) {
		return
	}
	mut var_product_id := rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('id'))
	if rt.is_true(Class_WC_Product_Usage_Notice.is_notice_throttled((var_user_id).to_i64(), (var_product_id).to_i64())) {
		return
	}
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_product_usage_notice_scripts' }])])
}

fn Class_WC_Product_Usage_Notice.is_remind_later_clicked_recently(user_id i64, product_id i64) bool {
	mut user_id_mutated := user_id
	mut product_id_mutated := product_id
	mut var_last_remind_later_ts := rt.call_function('absint', [rt.call_function('get_user_meta', [rt.new_int(user_id_mutated).clone(), rt.new_string(Class_WC_Product_Usage_Notice.remind_later_timestamp_meta_prefix() + product_id_mutated.str()), rt.new_bool(true)])])
	if rt.is_true(rt.identical(rt.new_int(0), var_last_remind_later_ts)) {
		return false
	}
	mut var_seconds_since_clicked_remind_later := rt.sub(rt.call_function('time', []rt.PhpVal{}), var_last_remind_later_ts)
	mut var_wait_after_remind_later := rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('wait_in_seconds_after_remind_later'))
	return (rt.less(var_seconds_since_clicked_remind_later, var_wait_after_remind_later)).to_bool()
}

fn Class_WC_Product_Usage_Notice.has_reached_max_dismissals(user_id i64, product_id i64) bool {
	mut user_id_mutated := user_id
	mut product_id_mutated := product_id
	mut var_dismiss_count := rt.call_function('absint', [rt.call_function('get_user_meta', [rt.new_int(user_id_mutated).clone(), rt.new_string(Class_WC_Product_Usage_Notice.dismissed_count_meta_prefix() + product_id_mutated.str()), rt.new_bool(true)])])
	mut var_max_dismissals := rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('max_dismissals'))
	return (rt.greater_equal(var_dismiss_count, var_max_dismissals)).to_bool()
}

fn Class_WC_Product_Usage_Notice.is_any_notices_dismissed_recently(user_id i64) bool {
	mut user_id_mutated := user_id
	mut var_global_last_dismissed_ts := rt.call_function('absint', [rt.call_function('get_user_meta', [rt.new_int(user_id_mutated).clone(), rt.new_string(Class_WC_Product_Usage_Notice.last_dismissed_timestamp_meta()), rt.new_bool(true)])])
	if rt.is_true(rt.identical(rt.new_int(0), var_global_last_dismissed_ts)) {
		return false
	}
	mut var_seconds_since_dismissed := rt.sub(rt.call_function('time', []rt.PhpVal{}), var_global_last_dismissed_ts)
	mut var_wait_after_any_dismisses := rt.get_static_prop('WC_Product_Usage_Notice', 'product_usage_notice_rules').array_get(rt.new_string('wait_in_seconds_after_any_dismisses'))
	return (rt.less(var_seconds_since_dismissed, var_wait_after_any_dismisses)).to_bool()
}

fn Class_WC_Product_Usage_Notice.is_product_notice_dismissed_recently(user_id i64, product_id i64) bool {
	mut user_id_mutated := user_id
	mut product_id_mutated := product_id
	mut var_last_dismissed_ts := rt.call_function('absint', [rt.call_function('get_user_meta', [rt.new_int(user_id_mutated).clone(), rt.new_string(Class_WC_Product_Usage_Notice.dismissed_timestamp_meta_prefix() + product_id_mutated.str()), rt.new_bool(true)])])
	if rt.is_true(rt.identical(rt.new_int(0), var_last_dismissed_ts)) {
		return false
	}
	mut var_seconds_since_dismissed := rt.sub(rt.call_function('time', []rt.PhpVal{}), var_last_dismissed_ts)
	mut var_wait_after_dismiss := rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('wait_in_seconds_after_dismiss'))
	return (rt.less(var_seconds_since_dismissed, var_wait_after_dismiss)).to_bool()
}

fn Class_WC_Product_Usage_Notice.is_notice_throttled(user_id i64, product_id i64) bool {
	mut user_id_mutated := user_id
	mut product_id_mutated := product_id
	return rt.is_true(Class_WC_Product_Usage_Notice.is_remind_later_clicked_recently(user_id_mutated, product_id_mutated)) || rt.is_true(Class_WC_Product_Usage_Notice.has_reached_max_dismissals(user_id_mutated, product_id_mutated)) || rt.is_true(Class_WC_Product_Usage_Notice.is_any_notices_dismissed_recently(user_id_mutated)) || rt.is_true(Class_WC_Product_Usage_Notice.is_product_notice_dismissed_recently(user_id_mutated, product_id_mutated))
}

fn Class_WC_Product_Usage_Notice.enqueue_product_usage_notice_scripts() {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_2 := iife_temp_2.register_style(rt.new_string('woo-product-usage-notice'), rt.new_string('style'), rt.create_array([rt.ArrayItem{ key: none, val: 'wp-components' }]))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets{}
	mut iife_result_3 := iife_temp_3.register_script(rt.new_string('wp-admin-scripts'), rt.new_string('woo-product-usage-notice'), rt.new_bool(true))
	mut var_subscribe_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'add-to-cart', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_medium', val: 'product' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_modal_subscribe' }]), rt.new_string('https://woocommerce.com/cart/')])
	mut var_renew_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'renew_product', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'product_key', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('state')).array_get(rt.new_string('key')) }, rt.ArrayItem{ key: 'order_id', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('state')).array_get(rt.new_string('order_id')) }, rt.ArrayItem{ key: 'utm_source', val: 'pu' }, rt.ArrayItem{ key: 'utm_medium', val: 'product' }, rt.ArrayItem{ key: 'utm_campaign', val: 'pu_modal_renew' }]), rt.new_string('https://woocommerce.com/cart/')])
	rt.call_function('wp_localize_script', [rt.new_string('wc-admin-woo-product-usage-notice'), rt.new_string('wooProductUsageNotice'), rt.create_array([rt.ArrayItem{ key: 'subscribeUrl', val: var_subscribe_url }, rt.ArrayItem{ key: 'renewUrl', val: var_renew_url }, rt.ArrayItem{ key: 'dismissAction', val: 'woocommerce_dismiss_product_usage_notice' }, rt.ArrayItem{ key: 'remindLaterAction', val: 'woocommerce_remind_later_product_usage_notice' }, rt.ArrayItem{ key: 'productId', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('id')) }, rt.ArrayItem{ key: 'productName', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('name')) }, rt.ArrayItem{ key: 'productRegularPrice', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('regular_price')) }, rt.ArrayItem{ key: 'dismissNonce', val: rt.call_function('wp_create_nonce', [rt.new_string('dismiss_product_usage_notice')]) }, rt.ArrayItem{ key: 'remindLaterNonce', val: rt.call_function('wp_create_nonce', [rt.new_string('remind_later_product_usage_notice')]) }, rt.ArrayItem{ key: 'showAs', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('show_as')) }, rt.ArrayItem{ key: 'colorScheme', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('color_scheme')) }, rt.ArrayItem{ key: 'subscriptionState', val: rt.get_static_prop('WC_Product_Usage_Notice', 'current_notice_rule').array_get(rt.new_string('state')) }, rt.ArrayItem{ key: 'screenId', val: rt.get_property(rt.call_function('get_current_screen', []rt.PhpVal{}), 'id') }])])
}

fn Class_WC_Product_Usage_Notice.get_current_notice_rule(var_screen rt.PhpVal) rt.PhpVal {
	mut iter_1 := rt.get_static_prop('WC_Product_Usage_Notice', 'product_usage_notice_rules').array_get(rt.new_string('products')).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_rule := item_1.val
		mut var_product_id := item_1.key
		if !(var_rule.array_get(rt.new_string('screens')).array_isset(rt.get_property(var_screen, 'id'))) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Product_Usage_Notice.query_string_matches(var_screen.clone(), var_rule.clone()))))) {
			continue
		}
		var_product_id = rt.call_function('absint', [var_product_id.clone()])
		mut iife_temp_4 := Class_WC_Helper{}
		mut iife_result_4 := iife_temp_4.get_product_subscription_state(var_product_id.clone())
		mut var_state := iife_result_4
		if rt.is_true(var_state.array_get(rt.new_string('expired'))) || rt.is_true(var_state.array_get(rt.new_string('unregistered'))) {
			var_rule.array_set('id', var_product_id.clone())
			var_rule.array_set('state', var_state.clone())
			return var_rule.clone()
		}
	}
	return rt.new_array()
}

fn Class_WC_Product_Usage_Notice.query_string_matches(var_screen rt.PhpVal, var_rule rt.PhpVal) bool {
	mut var_rule_mutated := var_rule
	if !rt.is_true(var_rule_mutated.array_get(rt.new_string('screens')).array_get(rt.get_property(var_screen, 'id')).array_get(rt.new_string('qs'))) {
		return true
	}
	mut var_qs := var_rule_mutated.array_get(rt.new_string('screens')).array_get(rt.get_property(var_screen, 'id')).array_get(rt.new_string('qs'))
	mut iter_2 := var_qs.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_val := item_2.val
		mut var_key := item_2.key
		if !rt.is_true(rt.get_superglobal('_GET').array_get(var_key)) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_superglobal('_GET').array_get(var_key), var_val)))) {
			return false
		}
	}
	return true
}

fn Class_WC_Product_Usage_Notice.ajax_dismiss() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('dismiss_product_usage_notice')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_product_id := rt.call_function('absint', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('product_id'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('product_id')) } else { rt.new_int(0) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_dismiss_count := rt.call_function('absint', [rt.call_function('get_user_meta', [var_user_id.clone(), rt.new_string(Class_WC_Product_Usage_Notice.dismissed_count_meta_prefix() + (var_product_id).str()), rt.new_bool(true)])])
	rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string(Class_WC_Product_Usage_Notice.dismissed_count_meta_prefix() + (var_product_id).str()), rt.add(var_dismiss_count, rt.new_int(1))])
	rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string(Class_WC_Product_Usage_Notice.dismissed_timestamp_meta_prefix() + (var_product_id).str()), rt.call_function('time', []rt.PhpVal{})])
	rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string(Class_WC_Product_Usage_Notice.last_dismissed_timestamp_meta()), rt.call_function('time', []rt.PhpVal{})])
	rt.call_function('wp_die', [rt.new_int(1)])
}

fn Class_WC_Product_Usage_Notice.ajax_remind_later() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('remind_later_product_usage_notice')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_product_id := rt.call_function('absint', [if !(rt.get_superglobal('_GET').array_get(rt.new_string('product_id'))).is_null() { rt.get_superglobal('_GET').array_get(rt.new_string('product_id')) } else { rt.new_int(0) }])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	rt.call_function('update_user_meta', [var_user_id.clone(), rt.new_string(Class_WC_Product_Usage_Notice.remind_later_timestamp_meta_prefix() + (var_product_id).str()), rt.call_function('time', []rt.PhpVal{})])
	rt.call_function('wp_die', [rt.new_int(1)])
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_WCAdminAssets {
	rt.PhpObjectBase
}

fn create_wc_product_usage_notice(_args ...rt.PhpVal) &Class_WC_Product_Usage_Notice {
	mut obj := &Class_WC_Product_Usage_Notice{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
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

fn (mut this Class_WC_Product_Usage_Notice) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'load' {
			Class_WC_Product_Usage_Notice.load()
			return rt.new_null()
		}
		'maybe_show_product_usage_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Product_Usage_Notice.maybe_show_product_usage_notice(dispatch_arg_0)
			return rt.new_null()
		}
		'is_remind_later_clicked_recently' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Product_Usage_Notice.is_remind_later_clicked_recently(dispatch_arg_0, dispatch_arg_1))
		}
		'has_reached_max_dismissals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Product_Usage_Notice.has_reached_max_dismissals(dispatch_arg_0, dispatch_arg_1))
		}
		'is_any_notices_dismissed_recently' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Product_Usage_Notice.is_any_notices_dismissed_recently(dispatch_arg_0))
		}
		'is_product_notice_dismissed_recently' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Product_Usage_Notice.is_product_notice_dismissed_recently(dispatch_arg_0, dispatch_arg_1))
		}
		'is_notice_throttled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_WC_Product_Usage_Notice.is_notice_throttled(dispatch_arg_0, dispatch_arg_1))
		}
		'enqueue_product_usage_notice_scripts' {
			Class_WC_Product_Usage_Notice.enqueue_product_usage_notice_scripts()
			return rt.new_null()
		}
		'get_current_notice_rule' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Product_Usage_Notice.get_current_notice_rule(dispatch_arg_0)
		}
		'query_string_matches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Product_Usage_Notice.query_string_matches(dispatch_arg_0, dispatch_arg_1))
		}
		'ajax_dismiss' {
			Class_WC_Product_Usage_Notice.ajax_dismiss()
			return rt.new_null()
		}
		'ajax_remind_later' {
			Class_WC_Product_Usage_Notice.ajax_remind_later()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_Usage_Notice) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Usage_Notice) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	Class_WC_Product_Usage_Notice.load()
}
