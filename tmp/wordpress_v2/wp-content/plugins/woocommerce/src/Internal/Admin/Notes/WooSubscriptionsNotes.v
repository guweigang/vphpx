import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.last_refresh_option_key() string {
	return 'woocommerce_admin-wc-helper-last-refresh'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.note_name() string {
	return 'wc-admin-wc-helper-connection'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.connection_note_name() string {
	return 'wc-admin-wc-helper-connection'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name() string {
	return 'wc-admin-wc-helper-subscription'
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.notify_when_days_left() i64 {
	return 60
}

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.bump_thresholds() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 60 },
		rt.ArrayItem{ key: none, val: 45 }, rt.ArrayItem{ key: none, val: 20 },
		rt.ArrayItem{ key: none, val: 7 }, rt.ArrayItem{ key: none, val: 1 }])
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) construct() {
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_head' },
		])])
	rt.call_function('add_action', [
		rt.new_string('update_option_woocommerce_helper_data'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'update_option_woocommerce_helper_data' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) update_option_woocommerce_helper_data(var_old_value rt.PhpVal, var_value rt.PhpVal) {
	mut var_old_value_mutated := var_old_value
	mut var_value_mutated := var_value
	if !(var_old_value_mutated.clone().is_array()) {
		var_old_value_mutated = rt.new_array()
	}
	if !(var_value_mutated.clone().is_array()) {
		var_value_mutated = rt.new_array()
	}
	mut var_old_auth := if rt.is_true(rt.new_bool(var_old_value_mutated.clone().array_isset(rt.new_string('auth')))) {
		var_old_value_mutated.array_get(rt.new_string('auth'))
	} else {
		rt.new_array()
	}
	mut var_new_auth := if rt.is_true(rt.new_bool(var_value_mutated.clone().array_isset(rt.new_string('auth')))) {
		var_value_mutated.array_get(rt.new_string('auth'))
	} else {
		rt.new_array()
	}
	mut var_old_token := if rt.is_true(rt.new_bool(var_old_auth.clone().array_isset(rt.new_string('access_token')))) {
		var_old_auth.array_get(rt.new_string('access_token'))
	} else {
		rt.new_string('')
	}
	mut var_new_token := if rt.is_true(rt.new_bool(var_new_auth.clone().array_isset(rt.new_string('access_token')))) {
		var_new_auth.array_get(rt.new_string('access_token'))
	} else {
		rt.new_string('')
	}
	if !(!rt.is_true(var_old_token)) && !rt.is_true(var_new_token) {
		this.remove_notes()
		return
	}
	if this.is_connected() {
		this.remove_notes()
		this.refresh_subscription_notes()
		return
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) admin_head() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_PageController{}
	mut iife_result_0 := iife_temp_0.is_admin_or_embed_page()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	this.check_connection()
	if this.is_connected() {
		mut var_refresh_notes := rt.new_bool(false)
		if rt.get_superglobal('_GET').array_isset(rt.new_string('wc-helper-status')) {
			var_refresh_notes = rt.new_bool(true)
		}
		mut var_time_now_gmt := rt.call_function('current_time', [
			rt.new_string('timestamp'),
			rt.new_int(0),
		])
		mut var_last_refresh := rt.new_int(rt.call_function('get_option', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.last_refresh_option_key(),
			rt.new_int(0),
		]).to_i64())
		if rt.is_true(rt.less_equal(rt.add(var_last_refresh, rt.get_constant('DAY_IN_SECONDS')),
			var_time_now_gmt))
		{
			rt.call_function('update_option', [
				Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.last_refresh_option_key(),
				var_time_now_gmt.clone(),
			])
			var_refresh_notes = rt.new_bool(true)
		}
		if rt.is_true(var_refresh_notes) {
			this.refresh_subscription_notes()
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) check_connection() {
	if !(this.is_connected()) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_1 := iife_temp_1.load_data_store()
		mut var_data_store := iife_result_1
		mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.connection_note_name(),
		])
		if !(!rt.is_true(var_note_ids)) {
			return
		}
		this.remove_notes()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) is_connected() bool {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options{}
	mut iife_result_2 := iife_temp_2.get(rt.new_string('auth'))
	mut var_auth := iife_result_2
	return !(!rt.is_true(var_auth.array_get(rt.new_string('access_token'))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) get_connected_site_id() bool {
	if !(this.is_connected()) {
		return false
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options{}
	mut iife_result_3 := iife_temp_3.get(rt.new_string('auth'))
	mut var_auth := iife_result_3
	return (rt.call_function('absint', [var_auth.array_get(rt.new_string('site_id'))])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) get_subscription_active_product_ids() rt.PhpVal {
	mut var_site_id := rt.new_bool(this.get_connected_site_id())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id)))) {
		return rt.new_array()
	}
	mut var_product_ids := rt.new_array()
	if this.is_connected() {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper{}
		mut iife_result_4 := iife_temp_4.get_subscriptions()
		mut var_subscriptions := iife_result_4
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_Notes_Exception') {
			mut var_e := var_e_1.clone()
			var_subscriptions = rt.new_array()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
		mut iter_1 := rt.cast_array(var_subscriptions).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subscription := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_site_id.clone(),
				var_subscription.array_get(rt.new_string('connections')),
				rt.new_bool(true)]))
			{
				var_product_ids.array_push(var_subscription.array_get(rt.new_string('product_id')))
			}
		}
	}
	return var_product_ids.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) remove_notes() {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_5 :=
		iife_temp_5.delete_notes_with_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.connection_note_name())
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_6 :=
		iife_temp_6.delete_notes_with_name(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) get_product_id_from_subscription_note(var_note rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	if !(var_note_mutated.clone().is_object()) {
		return rt.new_bool(false)
	}
	mut var_content_data := rt.call_method(var_note_mutated, 'get_content_data', []rt.PhpVal{})
	if rt.is_true(rt.call_function('property_exists', [var_content_data.clone(),
		rt.new_string('product_id')]))
	{
		return rt.new_int(rt.get_property(var_content_data, 'product_id').to_i64())
	}
	return rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) prune_inactive_subscription_notes() {
	mut var_active_product_ids := this.get_subscription_active_product_ids()
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_7 := iife_temp_7.load_data_store()
	mut var_data_store := iife_result_7
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name(),
	])
	mut iter_2 := rt.cast_array(var_note_ids).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_note_id := item_2.val
		mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_8 := iife_temp_8.get_note(var_note_id.clone())
		mut var_note := iife_result_8
		mut var_product_id := this.get_product_id_from_subscription_note(var_note.clone())
		if !(!rt.is_true(var_product_id)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				var_product_id.clone(),
				var_active_product_ids.clone(),
				rt.new_bool(true),
			])))))
			{
				rt.call_method(var_note, 'delete', []rt.PhpVal{})
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) find_note_for_product_id(var_product_id rt.PhpVal) bool {
	mut var_product_id_mutated := var_product_id
	var_product_id_mutated = rt.new_int(var_product_id_mutated.clone().to_i64())
	mut iife_temp_9 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_9 := iife_temp_9.load_data_store()
	mut var_data_store := iife_result_9
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name(),
	])
	mut iter_3 := rt.cast_array(var_note_ids).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_note_id := item_3.val
		mut iife_temp_10 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
		mut iife_result_10 := iife_temp_10.get_note(var_note_id.clone())
		mut var_note := iife_result_10
		mut var_found_product_id := this.get_product_id_from_subscription_note(var_note.clone())
		if rt.is_true(rt.identical(var_product_id_mutated, var_found_product_id)) {
			return var_note.to_bool()
		}
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) delete_any_note_for_product_id(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	var_product_id_mutated = rt.new_int(var_product_id_mutated.clone().to_i64())
	mut var_note := rt.new_bool(this.find_note_for_product_id(var_product_id_mutated.clone()))
	if rt.is_true(var_note) {
		rt.call_method(var_note, 'delete', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) add_or_update_subscription_expiring(var_subscription rt.PhpVal) {
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	mut var_product_name := var_subscription.array_get(rt.new_string('product_name'))
	mut var_expires := rt.new_int(var_subscription.array_get(rt.new_string('expires')).to_i64())
	mut var_time_now_gmt := rt.call_function('current_time', [
		rt.new_string('timestamp'), rt.new_int(0)])
	mut var_days_until_expiration := rt.new_int(rt.call_function('ceil', [
		rt.div(rt.sub(var_expires, var_time_now_gmt), rt.get_constant('DAY_IN_SECONDS')),
	]).to_i64())
	mut var_note := rt.new_bool(this.find_note_for_product_id(var_product_id.clone()))
	if rt.is_true(var_note)
		&& rt.is_true(rt.call_function('property_exists', [rt.call_method(var_note, 'get_content_data', []rt.PhpVal{}), rt.new_string('days_until_expiration')])) {
		mut var_note_days_until_expiration := rt.new_int(rt.get_property(rt.call_method(var_note,
			'get_content_data', []rt.PhpVal{}), 'days_until_expiration').to_i64())
		if rt.is_true(rt.identical(var_days_until_expiration, var_note_days_until_expiration)) {
			return
		}
		mut iter_4 :=
			rt.cast_array(Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.bump_thresholds()).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_bump_threshold := item_4.val
			if rt.is_true(rt.greater(var_note_days_until_expiration, var_bump_threshold))
				&& rt.is_true(rt.less_equal(var_days_until_expiration, var_bump_threshold)) {
				rt.call_method(var_note, 'delete', []rt.PhpVal{})
				var_note = rt.new_bool(false)
				break
			}
		}
	}
	mut var_note_title := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%s subscription expiring soon'),
			rt.new_string('woocommerce')]),
		var_product_name.clone(),
	])
	mut var_note_content := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Your subscription expires in %d days. Enable autorenew to avoid losing updates and access to support.'),
			rt.new_string('woocommerce'),
		]),
		var_days_until_expiration.clone(),
	])
	mut var_note_content_data := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'product_id', val: var_product_id },
		rt.ArrayItem{ key: 'product_name', val: var_product_name },
		rt.ArrayItem{ key: 'expired', val: false },
		rt.ArrayItem{ key: 'days_until_expiration', val: var_days_until_expiration },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		var_note = create_automattic_woocommerce_admin_notes_note()
	}
	rt.call_method(var_note, 'set_title', [var_note_title.clone()])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'clear_actions', []rt.PhpVal{})
	rt.call_method(var_note, 'add_action', [rt.new_string('enable-autorenew'),
		rt.call_function('__', [rt.new_string('Enable Autorenew'),
			rt.new_string('woocommerce')]),
		rt.new_string('https://woocommerce.com/my-account/my-subscriptions/?utm_medium=product')])
	rt.call_method(var_note, 'set_content', [var_note_content.clone()])
	rt.call_method(var_note, 'set_content_data', [var_note_content_data.clone()])
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) add_or_update_subscription_expired(var_subscription rt.PhpVal) {
	mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
	mut var_product_name := var_subscription.array_get(rt.new_string('product_name'))
	mut var_product_page := var_subscription.array_get(rt.new_string('product_url'))
	mut var_expires := rt.new_int(var_subscription.array_get(rt.new_string('expires')).to_i64())
	mut var_expires_date := rt.call_function('gmdate', [rt.new_string('F jS'),
		var_expires.clone()])
	mut var_note := rt.new_bool(this.find_note_for_product_id(var_product_id.clone()))
	if rt.is_true(var_note) {
		mut var_note_content_data := rt.call_method(var_note, 'get_content_data', []rt.PhpVal{})
		if rt.is_true(rt.get_property(var_note_content_data, 'expired')) {
			return
		}
	}
	mut var_note_title := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('%s subscription expired'),
			rt.new_string('woocommerce')]),
		var_product_name.clone(),
	])
	mut var_note_content := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Your subscription expired on %s. Get a new subscription to continue receiving updates and access to support.'),
			rt.new_string('woocommerce'),
		]),
		var_expires_date.clone(),
	])
	var_note_content_data = rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'product_id', val: var_product_id },
		rt.ArrayItem{ key: 'product_name', val: var_product_name },
		rt.ArrayItem{ key: 'expired', val: true },
		rt.ArrayItem{ key: 'expires', val: var_expires },
		rt.ArrayItem{ key: 'expires_date', val: var_expires_date },
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		var_note = create_automattic_woocommerce_admin_notes_note()
	}
	rt.call_method(var_note, 'set_title', [var_note_title.clone()])
	rt.call_method(var_note, 'set_content', [var_note_content.clone()])
	rt.call_method(var_note, 'set_content_data', [var_note_content_data.clone()])
	rt.call_method(var_note, 'set_type', [
		Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning(),
	])
	rt.call_method(var_note, 'set_name', [
		Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.subscription_note_name(),
	])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'clear_actions', []rt.PhpVal{})
	rt.call_method(var_note, 'add_action', [rt.new_string('renew-subscription'),
		rt.call_function('__', [rt.new_string('Renew Subscription'),
			rt.new_string('woocommerce')]),
		var_product_page.clone()])
	rt.call_method(var_note, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) refresh_subscription_notes() {
	if !(this.is_connected()) {
		return
	}
	this.prune_inactive_subscription_notes()
	mut iife_temp_11 := Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper{}
	mut iife_result_11 := iife_temp_11.get_subscriptions()
	mut var_subscriptions := iife_result_11
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Internal_Admin_Notes_Exception') {
		mut var_e := var_e_2.clone()
		var_subscriptions = rt.new_array()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	mut var_active_product_ids := this.get_subscription_active_product_ids()
	mut iter_5 := rt.cast_array(var_subscriptions).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_subscription := item_5.val
		mut var_product_id := var_subscription.array_get(rt.new_string('product_id'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_product_id.clone(), var_active_product_ids.clone(),
			rt.new_bool(true)])))))
		{
			continue
		}
		if rt.is_true(var_subscription.array_get(rt.new_string('autorenew'))) {
			this.delete_any_note_for_product_id(var_product_id.clone())
			continue
		}
		mut var_first_threshold := rt.mul(rt.get_constant('DAY_IN_SECONDS'),
			Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes.bump_thresholds().array_get(rt.new_int(0)))
		mut var_expires := rt.new_int(var_subscription.array_get(rt.new_string('expires')).to_i64())
		mut var_time_now_gmt := rt.call_function('current_time', [
			rt.new_string('timestamp'),
			rt.new_int(0),
		])
		if rt.is_true(rt.greater(var_expires, rt.add(var_time_now_gmt, var_first_threshold))) {
			this.delete_any_note_for_product_id(var_product_id.clone())
			continue
		}
		if rt.is_true(rt.greater(var_expires, var_time_now_gmt)) {
			this.add_or_update_subscription_expiring(var_subscription.clone())
			continue
		}
		this.add_or_update_subscription_expired(var_subscription.clone())
	}
}

struct Class_Automattic_WooCommerce_Admin_PageController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_woosubscriptionsnotes() &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_pagecontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PageController {
	mut obj := &Class_Automattic_WooCommerce_Admin_PageController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_wc_helper_options(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_wc_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'update_option_woocommerce_helper_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_option_woocommerce_helper_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'admin_head' {
			this.admin_head()
			return rt.new_null()
		}
		'check_connection' {
			this.check_connection()
			return rt.new_null()
		}
		'is_connected' {
			return rt.new_bool(this.is_connected())
		}
		'get_connected_site_id' {
			return rt.new_bool(this.get_connected_site_id())
		}
		'get_subscription_active_product_ids' {
			return this.get_subscription_active_product_ids()
		}
		'remove_notes' {
			this.remove_notes()
			return rt.new_null()
		}
		'get_product_id_from_subscription_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_id_from_subscription_note(dispatch_arg_0)
		}
		'prune_inactive_subscription_notes' {
			this.prune_inactive_subscription_notes()
			return rt.new_null()
		}
		'find_note_for_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.find_note_for_product_id(dispatch_arg_0))
		}
		'delete_any_note_for_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_any_note_for_product_id(dispatch_arg_0)
			return rt.new_null()
		}
		'add_or_update_subscription_expiring' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_or_update_subscription_expiring(dispatch_arg_0)
			return rt.new_null()
		}
		'add_or_update_subscription_expired' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_or_update_subscription_expired(dispatch_arg_0)
			return rt.new_null()
		}
		'refresh_subscription_notes' {
			this.refresh_subscription_notes()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WooSubscriptionsNotes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
