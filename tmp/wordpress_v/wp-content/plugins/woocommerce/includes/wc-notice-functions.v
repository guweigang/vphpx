import rt

fn wc_notice_count(notice_type string) i64 {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return 0
	}
	mut var_notice_count := 0
	mut var_all_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if rt.is_true(rt.new_bool(var_all_notices.array_isset(rt.new_string(notice_type)) && rt.is_true(rt.new_bool(var_all_notices.array_get(notice_type).is_array())))) {
		var_notice_count = var_all_notices.array_get(notice_type).array_count()
	} else if notice_type == '' {
		{
			mut iter_1 := var_all_notices.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_notices := item_1.val
				if rt.is_true(rt.call_function('is_countable', [var_notices.dup()])) {
					// unsupported expression: Expr_AssignOp_Plus
				}
			}
		}
	}
	return var_notice_count
}

fn wc_has_notice(var_message rt.PhpVal, notice_type string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return false
	}
	mut var_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	var_notices = if var_notices.array_isset(rt.new_string(notice_type)) { var_notices.array_get(notice_type) } else { rt.new_array() }
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn wc_add_notice(var_message rt.PhpVal, notice_type string, var_data rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before the WooCommerce session is initialized, or places where there is no session, e.g. WordPress admin.'), rt.new_string('woocommerce')]), rt.new_string('10.5')])
		return rt.new_null()
	}
	mut var_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if rt.is_true(rt.identical(rt.new_string('success'), rt.new_string(notice_type))) {
		var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_message'), var_message.dup()])
	}
	var_message = rt.call_function('apply_filters', ['woocommerce_add_' + notice_type, var_message.dup()])
	if !(!rt.is_true(var_message)) {
		var_notices.array_get_mut(notice_type).array_push(rt.create_array([rt.ArrayItem{ key: 'notice', val: var_message }, rt.ArrayItem{ key: 'data', val: var_data }]))
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), var_notices.dup()])
}

fn wc_set_notices(var_notices rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.6')])
		return rt.new_null()
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), if !rt.is_true(var_notices) { rt.new_null() } else { var_notices }])
}

fn wc_clear_notices() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [rt.new_string('wc_notices'), rt.new_null()])
}

fn wc_print_notices(return bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	mut var_session := rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session')
	if rt.is_true(rt.identical(rt.new_null(), var_session)) {
		return rt.new_null()
	}
	mut var_all_notices := rt.call_method(var_session, 'get', [rt.new_string('wc_notices'), rt.new_array()])
	mut var_notice_types := rt.call_function('apply_filters', [rt.new_string('woocommerce_notice_types'), rt.create_array([rt.ArrayItem{ key: none, val: 'error' }, rt.ArrayItem{ key: none, val: 'success' }, rt.ArrayItem{ key: none, val: 'notice' }])])
	rt.call_function('ob_start', []rt.PhpVal{})
	{
		mut iter_1 := var_notice_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_notice_type := item_1.val
			if wc_notice_count(var_notice_type.dup()) > 0 {
				mut var_messages := rt.new_array()
				{
					mut iter_2 := var_all_notices.array_get(var_notice_type).iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_notice := item_2.val
						var_messages << if var_notice.array_isset(rt.new_string('notice')) { var_notice.array_get('notice') } else { var_notice }
					}
				}
				rt.call_function('wc_get_template', [rt.new_string("notices/${var_notice_type.to_string()}.php"), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.call_function('array_filter', [var_messages.dup()]) }, rt.ArrayItem{ key: 'notices', val: rt.call_function('array_filter', [var_all_notices.array_get(var_notice_type)]) }])])
			}
		}
	}
	wc_clear_notices()
	mut var_notices := wc_kses_notice(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	if var_return {
		return var_notices.dup()
	}
	rt.echo_val(var_notices)
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn wc_print_notice(var_message rt.PhpVal, notice_type string, var_data rt.PhpVal, return bool) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('success'), rt.new_string(notice_type))) {
		var_message = rt.call_function('apply_filters', [rt.new_string('woocommerce_add_message'), var_message.dup()])
	}
	var_message = rt.call_function('apply_filters', ['woocommerce_add_' + notice_type, var_message.dup()])
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string("notices/${var_notice_type}.php"), rt.create_array([rt.ArrayItem{ key: 'messages', val: rt.create_array([rt.ArrayItem{ key: none, val: var_message }]) }, rt.ArrayItem{ key: 'notices', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'notice', val: var_message }, rt.ArrayItem{ key: 'data', val: var_data }]) }]) }])])
	mut var_notice := wc_kses_notice(rt.call_function('ob_get_clean', []rt.PhpVal{}))
	if var_return {
		return var_notice.dup()
	}
	rt.echo_val(var_notice)
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn wc_get_notices(notice_type string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('woocommerce_init')]))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('This function should not be called before woocommerce_init.'), rt.new_string('woocommerce')]), rt.new_string('2.3')])
		return rt.new_null()
	}
	mut var_notices := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'))))) {
		return var_notices.dup()
	}
	mut var_all_notices := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'get', [rt.new_string('wc_notices'), rt.new_array()])
	if notice_type == '' {
		var_notices = var_all_notices.dup()
	} else if var_all_notices.array_isset(rt.new_string(notice_type)) {
		var_notices = var_all_notices.array_get(notice_type)
	}
	return var_notices.dup()
}

fn wc_add_wp_error_notices(var_errors rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()])) && rt.is_true(rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{})))) {
		{
			mut iter_1 := rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_error := item_1.val
				wc_add_notice(var_error.dup(), 'error', rt.new_null())
			}
		}
	}
}

fn wc_kses_notice(var_message rt.PhpVal) rt.PhpVal {
	mut var_allowed_tags := rt.call_function('array_replace_recursive', [rt.call_function('wp_kses_allowed_html', [rt.new_string('post')]), rt.create_array([rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'tabindex', val: true }]) }])])
	return rt.call_function('wp_kses', [var_message.dup(), rt.call_function('apply_filters', [rt.new_string('woocommerce_kses_notice_allowed_tags'), var_allowed_tags.dup()])])
}

fn wc_get_notice_data_attr(var_notice rt.PhpVal) string {
	if !rt.is_true(var_notice.array_get('data')) {
		return ''
	}
	mut var_attr := ''
	{
		mut iter_1 := var_notice.array_get('data').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	return var_attr
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_notice_functions_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
