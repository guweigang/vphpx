import rt

struct Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) construct() {
	rt.call_function('add_action', [rt.new_string('deleted_user'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Utilities_WebhookUtil', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'reassign_webhooks_to_new_user_id' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('delete_user_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Utilities_WebhookUtil', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_render_user_with_webhooks_warning' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) reassign_webhooks_to_new_user_id(old_user_id i64, mut var_new_user_id Class_Automattic_WooCommerce_Internal_Utilities_?int) {
	mut var_webhook_ids := this.get_webhook_ids_for_user(old_user_id)
	mut iter_1 := var_webhook_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_webhook_id := item_1.val
		mut var_webhook := create_automattic_woocommerce_internal_utilities_wc_webhook(var_webhook_id.clone())
		var_webhook.set_user_id(if !(var_new_user_id).is_null() { var_new_user_id } else { rt.new_int(0) })
		var_webhook.save()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) maybe_render_user_with_webhooks_warning(mut var_current_user Class_Automattic_WooCommerce_Internal_Utilities_WP_User, mut var_userids Class_Automattic_WooCommerce_Internal_Utilities_array) {
	mut var_wpdb := rt.new_null()
	mut var_at_least_one_user_with_webhooks := rt.new_bool(false)
	mut iter_2 := var_userids.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_user_id := item_2.val
		mut var_webhook_ids := this.get_webhook_ids_for_user((var_user_id).to_i64())
		if !rt.is_true(var_webhook_ids) {
			continue
		}
		var_at_least_one_user_with_webhooks = rt.new_bool(true)
		mut var_user_data := rt.call_function('get_userdata', [var_user_id.clone()])
		mut var_user_login := if rt.is_true(rt.identical(rt.new_bool(false), var_user_data)) { rt.new_string('') } else { rt.get_property(var_user_data, 'user_login') }
		mut var_webhooks_count := rt.new_int(var_webhook_ids.clone().array_count())
		mut var_text := rt.call_function('sprintf', [rt.call_function('_nx', [rt.new_string('User #%1$s %2$s has created %3$d WooCommerce webhook.'), rt.new_string('User #%1$s %2$s has created %3$d WooCommerce webhooks.'), var_webhooks_count.clone(), rt.new_string('user webhook count'), rt.new_string('woocommerce')]), var_user_id.clone(), var_user_login.clone(), var_webhooks_count.clone()])
		print('<p>' + (rt.call_function('esc_html', [var_text.clone()])).str() + '</p>')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_at_least_one_user_with_webhooks)))) {
		return
	}
	mut var_webhooks_settings_url := rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=advanced&section=webhooks')])])
	mut var_users_have_content := rt.new_bool((rt.call_function('apply_filters', [rt.new_string('users_have_additional_content'), rt.new_bool(false), var_userids])).to_bool())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_users_have_content)))) {
		if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_author IN( ')) + (rt.call_function('implode', [rt.new_string(','), var_userids])).str() + ' ) LIMIT 1').str())])) {
		var_users_have_content = rt.new_bool(true)
		} else if rt.is_true(rt.call_method(var_wpdb, 'get_var', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' WHERE link_owner IN( ')) + (rt.call_function('implode', [rt.new_string(','), var_userids])).str() + ' ) LIMIT 1').str())])) {
		var_users_have_content = rt.new_bool(true)
		}
	}
	if rt.is_true(var_users_have_content) {
	mut var_text := rt.call_function('__', [rt.new_string('If the "Delete all content" option is selected, the affected WooCommerce webhooks will <b>not</b> be deleted and will be attributed to user id 0.<br/>'), rt.new_string('woocommerce')])
	} else {
	var_text = rt.call_function('__', [rt.new_string('The affected WooCommerce webhooks will <b>not</b> be deleted and will be attributed to user id 0.<br/>'), rt.new_string('woocommerce')])
	}
	var_text = rt.concat(var_text, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('After that they can be reassigned to the logged-in user by going to the <a href="%1$s">WooCommerce webhooks settings page</a> and re-saving them.'), rt.new_string('woocommerce')]), var_webhooks_settings_url.clone()]))
	print('<p>' + (rt.call_function('wp_kses_post', [var_text.clone()])).str() + '</p>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) get_webhook_ids_for_user(user_id i64) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('webhook'))
	mut var_data_store := iife_result_0
	return rt.call_method(var_data_store, 'search_webhooks', [rt.create_array([rt.ArrayItem{ key: 'user_id', val: user_id }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) get_legacy_webhooks_count(clear_cache bool) i64 {
	mut var_wpdb := rt.new_null()
	mut iife_temp_1 := Class_WC_Cache_Helper{}
	mut iife_result_1 := iife_temp_1.get_cache_prefix(rt.new_string('webhooks'))
	mut var_cache_key := rt.new_string((iife_result_1).str() + 'legacy_count')
	if var_clear_cache {
		rt.call_function('wp_cache_delete', [var_cache_key.clone(), rt.new_string('webhooks')])
	}
	mut var_count := rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('webhooks')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		var_count = rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.concat(rt.concat(rt.new_string('SELECT count( webhook_id ) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_webhooks WHERE `api_version` < 1;'))])])
		rt.call_function('wp_cache_add', [var_cache_key.clone(), var_count.clone(), rt.new_string('webhooks')])
	}
	return (var_count).to_i64()
}

struct Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_utilities_webhookutil() &Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_utilities_wc_webhook(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_wc_data_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'reassign_webhooks_to_new_user_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_?int](if args.len > 1 { args[1] } else { rt.new_null() })
			this.reassign_webhooks_to_new_user_id(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_render_user_with_webhooks_warning' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_WP_User](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.maybe_render_user_with_webhooks_warning(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_webhook_ids_for_user' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_webhook_ids_for_user(dispatch_arg_0)
		}
		'get_legacy_webhooks_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.get_legacy_webhooks_count(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WebhookUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Webhook) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
