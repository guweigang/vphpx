import rt

fn wc_notice_count(notice_type string) i64 {
	mut var_notice_type := notice_type
	mut var_notice_count := i64(0)
	mut var_all_notices := rt.new_null()
	mut var_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return 0
	}
	var_notice_count = 0
	var_all_notices = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if var_all_notices.array_isset(rt.new_string(notice_type)) && var_all_notices.array_get(rt.new_string(notice_type)).is_array() {
	var_notice_count = var_all_notices.array_get(rt.new_string(notice_type)).array_count()
	} else if notice_type == '' {
		mut iter_1 := var_all_notices.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_notices_shadow := item_1.val
			if rt.is_true(rt.call_function('is_countable', [var_notices_shadow.clone()])) {
				var_notice_count = var_notice_count + var_notices_shadow.clone().array_count()
			}
		}
	}
	return var_notice_count
}

fn wc_has_notice(var_message rt.PhpVal, notice_type string) bool {
	mut var_notice_type := notice_type
	mut var_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return false
	}
	var_notices = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	var_notices = if var_notices.array_isset(rt.new_string(notice_type)) { var_notices.array_get(rt.new_string(notice_type)) } else { rt.new_array() }
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('array_search', [var_message.clone(), rt.call_function('wp_list_pluck', [var_notices.clone(), rt.new_string('notice')]), rt.new_bool(true)]), rt.new_bool(false))))
}

fn wc_add_notice(var_message_arg rt.PhpVal, notice_type string, var_data rt.PhpVal) {
	mut var_notice_type := notice_type
	mut var_message := var_message_arg
	mut var_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before the WooCommerce session is initialized, or places where there is no session, e.g. WordPress admin.'), rt.new_string('woocommerce')]), rt.new_string('10.5')])
		return
	}
	var_notices = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if rt.is_true(rt.identical(rt.new_string('success'), rt.new_string(notice_type))) {
	var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_message'), var_message.clone()])
	}
	var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_' + notice_type), var_message.clone()])
	if !(!rt.is_true(var_message)) {
		var_notices.array_get_mut(notice_type).array_push(rt.create_array([rt.ArrayItem{ key: 'notice', val: var_message }, rt.ArrayItem{ key: 'data', val: var_data }]))
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), var_notices.clone()])
}

fn wc_set_notices(var_notices rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.6')])
		return
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), if !rt.is_true(var_notices) { rt.new_null() } else { var_notices }])
}

fn wc_clear_notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), rt.new_null()])
}

fn wc_print_notices(return bool) rt.PhpVal {
	mut var_return := return
	mut var_session := rt.new_null()
	mut var_all_notices := rt.new_null()
	mut var_notice_types := rt.new_null()
	mut var_notice_type := rt.new_null()
	mut var_messages := []rt.PhpVal{}
	mut var_notice := rt.new_null()
	mut var_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	var_session = rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	if rt.is_true(rt.identical(rt.new_null(), var_session)) {
		return rt.new_null()
	}
	var_all_notices = rt.call_method(var_session, 'get', [rt.new_string('wc_notices'), rt.new_array()])
	var_notice_types = rt.call_function('apply_filters', [rt.new_string('woocommerce_notice_types'), rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'success' }, rt.ArrayItem{ key: none, val: 'notice' }])])
	rt.call_function('ob_start', []rt.PhpVal{})
	mut iter_2 := var_notice_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_notice_type_shadow := item_2.val
		if wc_notice_count(var_notice_type_shadow.clone()) > 0 {
			var_messages = rt.new_array()
			mut iter_3 := var_all_notices.array_get(var_notice_type_shadow).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_notice_shadow := item_3.val
				var_messages << if var_notice_shadow.array_isset(rt.new_string('notice')) { var_notice_shadow.array_get(rt.new_string('notice')) } else { var_notice_shadow }
			}
			rt.call_function('wc_get_template', [rt.new_string("notices/${var_notice_type.to_string()}.php"), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.call_function('array_filter', [rt.create_array_from_list(var_messages)]) }, rt.ArrayItem{ key: 'notices', val: rt.call_function('array_filter', [var_all_notices.array_get(var_notice_type_shadow)]) }])])
		}
	}
	wc_clear_notices()
	var_notices = wc_kses_notice(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	if var_return {
		return var_notices.clone()
	}
	rt.echo_val(var_notices)
	return rt.new_null()
}

fn wc_print_notice(var_message_arg rt.PhpVal, notice_type string, var_data rt.PhpVal, return bool) rt.PhpVal {
	mut var_notice_type := notice_type
	mut var_return := return
	mut var_message := var_message_arg
	mut var_notice := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('success'), rt.new_string(notice_type))) {
	var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_message'), var_message.clone()])
	}
	var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_' + notice_type), var_message.clone()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string("notices/${var_notice_type}.php"), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: none, val: var_message }]) }, rt.ArrayItem{ key: 'notices', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'notice', val: var_message }, rt.ArrayItem{ key: 'data', val: var_data }]) }]) }])])
	var_notice = wc_kses_notice(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	if var_return {
		return var_notice.clone()
	}
	rt.echo_val(var_notice)
	return rt.new_null()
}

fn wc_get_notices(notice_type string) rt.PhpVal {
	mut var_notice_type := notice_type
	mut var_notices := rt.new_null()
	mut var_all_notices := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	var_notices = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		return var_notices.clone()
	}
	var_all_notices = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if notice_type == '' {
	var_notices = var_all_notices.clone()
	} else if var_all_notices.array_isset(rt.new_string(notice_type)) {
	var_notices = var_all_notices.array_get(rt.new_string(notice_type))
	}
	return var_notices.clone()
}

fn wc_add_wp_error_notices(var_errors rt.PhpVal) {
	mut var_error := rt.new_null()
	if rt.is_true(rt.call_function('is_wp_error', [var_errors.clone()])) && rt.is_true(rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{})) {
		mut iter_4 := rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_error_shadow := item_4.val
			wc_add_notice(var_error_shadow.clone(), 'error', rt.new_null())
		}
	}
}

fn wc_kses_notice(var_message rt.PhpVal) rt.PhpVal {
	mut var_allowed_tags := rt.new_null()
	var_allowed_tags = rt.call_function('array_replace_recursive', [rt.call_function('wp_kses_allowed_html', [rt.new_string('post')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'tabindex', val: true }]) }])])
	return rt.call_function('wp_kses', [var_message.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_kses_notice_allowed_tags'), var_allowed_tags.clone()])])
}

fn wc_get_notice_data_attr(var_notice rt.PhpVal) string {
	mut var_attr := ''
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	if !rt.is_true(var_notice.array_get(rt.new_string('data'))) {
		return ''
	}
	var_attr = ''
	mut iter_5 := var_notice.array_get(rt.new_string('data')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value_shadow := item_5.val
		mut var_key_shadow := item_5.key
		var_attr = var_attr + (rt.call_function('sprintf', [rt.new_string(' data-%1$s="%2$s"'), rt.call_function('sanitize_title', [var_key_shadow.clone()]), rt.call_function('esc_attr', [var_value_shadow.clone()])])).str()
	}
	return var_attr
}


fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}
