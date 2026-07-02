import rt
import crypto.sha1

fn wc_maybe_define_constant(name string, value bool) {
	mut var_name := name
	mut var_value := value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string(name)]))))) {
		rt.call_function('define', [rt.new_string(name), rt.new_bool(value)])
	}
}

fn wc_create_order(var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_args := var_args_arg
	mut var_default_args := map[string]rt.PhpVal{}
	mut var_order := rt.new_null()
	mut var_e := rt.new_null()
	var_default_args = { 'status': rt.new_null(), 'customer_id': rt.new_null(), 'customer_note': rt.new_null(), 'parent': rt.new_null(), 'created_via': rt.new_null(), 'cart_hash': rt.new_null(), 'order_id': rt.new_int(0) }
	var_args = rt.call_function('wp_parse_args', [rt.create_array_from_native_map(var_args), rt.create_array_from_native_map(var_default_args)])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order = create_wc_order(var_args.array_get(rt.new_string('order_id')))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('parent')).is_null()) {
		var_order.set_parent_id(rt.call_function('absint', [var_args.array_get(rt.new_string('parent'))]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('status')).is_null()) {
		var_order.set_status(var_args.array_get(rt.new_string('status')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('customer_note')).is_null()) {
		var_order.set_customer_note(var_args.array_get(rt.new_string('customer_note')))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('customer_id')).is_null()) {
		var_order.set_customer_id(if var_args.array_get(rt.new_string('customer_id')).is_long() || var_args.array_get(rt.new_string('customer_id')).is_double() { rt.call_function('absint', [var_args.array_get(rt.new_string('customer_id'))]) } else { rt.new_int(0) })
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('created_via')).is_null()) {
		var_order.set_created_via(rt.call_function('sanitize_text_field', [var_args.array_get(rt.new_string('created_via'))]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(var_args.array_get(rt.new_string('cart_hash')).is_null()) {
		var_order.set_cart_hash(rt.call_function('sanitize_text_field', [var_args.array_get(rt.new_string('cart_hash'))]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get(rt.new_string('order_id')))))) {
		var_order.set_currency(get_woocommerce_currency())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_order.set_prices_include_tax(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')])))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut iife_temp_0 := Class_WC_Geolocation{}
		mut iife_result_0 := iife_temp_0.get_ip_address()
		var_order.set_customer_ip_address(iife_result_0)
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_order.set_customer_user_agent(wc_get_user_agent())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_order.save()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		var_e = var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return mut var_order
}

fn wc_update_order(var_args rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_args['order_id']) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')])))
	}
	return mut wc_create_order(rt.create_array_from_native_map(var_args))
}

fn wc_tokenize_path(var_path_arg rt.PhpVal, var_path_tokens rt.PhpVal) rt.PhpVal {
	mut var_path := var_path_arg
	mut var_token_path := rt.new_null()
	mut var_token := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		var_a = rt.new_int(var_a.clone().to_string().len)
		var_b = rt.new_int(var_b.clone().to_string().len)
		if rt.is_true(rt.greater(var_a, var_b)) {
			return rt.new_int(-1)
		}
		if rt.is_true(rt.greater(var_b, var_a)) {
			return rt.new_int(1)
		}
		return rt.new_int(0)
		}
	rt.call_function('uasort', [var_path_tokens.clone(), rt.new_closure(closure_2_fn)])
	mut iter_1 := var_path_tokens.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_token_path_shadow := item_1.val
		mut var_token_shadow := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_path.clone(), var_token_path_shadow.clone()]))))) {
			continue
		}
	var_path = rt.call_function('str_replace', [var_token_path_shadow.clone(), rt.new_string('{{' + (var_token_shadow).str() + '}}'), var_path.clone()])
	}
	return var_path.clone()
}

fn wc_untokenize_path(var_path_arg rt.PhpVal, var_path_tokens rt.PhpVal) rt.PhpVal {
	mut var_path := var_path_arg
	mut var_token_path := rt.new_null()
	mut var_token := rt.new_null()
	mut iter_2 := var_path_tokens.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_token_path_shadow := item_2.val
		mut var_token_shadow := item_2.key
	var_path = rt.call_function('str_replace', [rt.new_string('{{' + (var_token_shadow).str() + '}}'), var_token_path_shadow.clone(), var_path.clone()])
	}
	return var_path.clone()
}

fn wc_get_path_define_tokens() rt.PhpVal {
	mut var_defines := []rt.PhpVal{}
	mut var_path_tokens := rt.new_null()
	mut var_define := rt.new_null()
	var_defines = ['ABSPATH', 'WP_CONTENT_DIR', 'WP_PLUGIN_DIR', 'WPMU_PLUGIN_DIR', 'PLUGINDIR', 'WP_THEME_DIR']
	var_path_tokens = rt.new_array()
	for var_define_shadow in var_defines {
		if rt.is_true(rt.call_function('defined', [rt.new_string((var_define_shadow).str()).clone()])) {
			var_path_tokens.array_set(rt.new_string((var_define_shadow).str()), rt.call_function('constant', [rt.new_string((var_define_shadow).str()).clone()]))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_path_define_tokens'), var_path_tokens.clone()])
}

fn wc_get_template_part(var_slug rt.PhpVal, name string) {
	mut var_name := name
	mut var_cache_key := rt.new_null()
	mut var_template := rt.new_null()
	mut var_fallback := rt.new_null()
	mut var_cache_path := rt.new_null()
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.get_constant(rt.new_string('WC_VERSION'))
	var_cache_key = rt.call_function('sanitize_key', [rt.call_function('implode', [rt.new_string('-'), rt.create_array([rt.ArrayItem{ key: none, val: 'template-part' }, rt.ArrayItem{ key: none, val: var_slug }, rt.ArrayItem{ key: none, val: name }, rt.ArrayItem{ key: none, val: iife_result_2 }])])])
	var_template = rt.new_string((rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')])).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		if var_name.len > 0 && var_name != '0' {
			var_template = if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) { rt.new_string('') } else { rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: "${var_slug.to_string()}-${var_name}.php" }, rt.ArrayItem{ key: none, val: (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + "${var_slug.to_string()}-${var_name}.php" }])]) }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
			var_fallback = rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + "/templates/${var_slug.to_string()}-${var_name}.php")
			var_template = if rt.is_true(rt.call_function('file_exists', [var_fallback.clone()])) { var_fallback } else { rt.new_string('') }
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		var_template = if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) { rt.new_string('') } else { rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: "${var_slug.to_string()}.php" }, rt.ArrayItem{ key: none, val: (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + "${var_slug.to_string()}.php" }])]) }
		}
		var_cache_path = wc_tokenize_path(var_template.clone(), wc_get_path_define_tokens())
		wc_set_template_cache(var_cache_key.clone(), var_cache_path.clone())
	} else {
	var_template = wc_untokenize_path(var_template.clone(), wc_get_path_define_tokens())
	}
	var_template = rt.call_function('apply_filters', [rt.new_string('wc_get_template_part'), var_template.clone(), var_slug.clone(), rt.new_string(name)])
	if rt.is_true(var_template) {
		rt.call_function('load_template', [var_template.clone(), rt.new_bool(false)])
	}
}

fn wc_get_template(var_template_name rt.PhpVal, var_args rt.PhpVal, template_path string, default_path string) {
	mut var_template_path := template_path
	mut var_default_path := default_path
	mut var_cache_key := rt.new_null()
	mut var_template := rt.new_null()
	mut var_cache_path := rt.new_null()
	mut var_filter_template := rt.new_null()
	mut var_action_args := map[string]rt.PhpVal{}
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WC_VERSION'))
	var_cache_key = rt.call_function('sanitize_key', [rt.call_function('implode', [rt.new_string('-'), rt.create_array([rt.ArrayItem{ key: none, val: 'template' }, rt.ArrayItem{ key: none, val: var_template_name }, rt.ArrayItem{ key: none, val: template_path }, rt.ArrayItem{ key: none, val: default_path }, rt.ArrayItem{ key: none, val: iife_result_3 }])])])
	var_template = rt.new_string((rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')])).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		var_template = wc_locate_template(var_template_name.clone(), template_path, default_path)
		var_cache_path = wc_tokenize_path(var_template.clone(), wc_get_path_define_tokens())
		wc_set_template_cache(var_cache_key.clone(), var_cache_path.clone())
	} else {
	var_template = wc_untokenize_path(var_template.clone(), wc_get_path_define_tokens())
	}
	var_filter_template = rt.call_function('apply_filters', [rt.new_string('wc_get_template'), var_template.clone(), var_template_name.clone(), rt.create_array_from_native_map(var_args), rt.new_string(template_path), rt.new_string(default_path)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_filter_template, var_template)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_filter_template.clone()]))))) {
			rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s does not exist.'), rt.new_string('woocommerce')]), rt.new_string('<code>' + (var_filter_template).str() + '</code>')]), rt.new_string('2.1')])
			return
		}
	var_template = var_filter_template.clone()
	}
	var_action_args = { 'template_name': var_template_name, 'template_path': rt.new_string(template_path), 'located': var_template, 'args': var_args }
	if !(!rt.is_true(var_args)) && rt.create_array_from_native_map(var_args).is_array() {
		if var_args.array_isset(rt.new_string('action_args')) {
			rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('action_args should not be overwritten when calling wc_get_template.'), rt.new_string('woocommerce')]), rt.new_string('3.6.0')])
			var_args.array_unset(rt.new_string('action_args'))
		}
		rt.call_function('extract', [rt.create_array_from_native_map(var_args)])
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_before_template_part'), var_action_args['template_name'], var_action_args['template_path'], var_action_args['located'], var_action_args['args']])
	rt.include_file((var_action_args['located']).to_string(), '1')
	rt.call_function('do_action', [rt.new_string('woocommerce_after_template_part'), var_action_args['template_name'], var_action_args['template_path'], var_action_args['located'], var_action_args['args']])
}

fn wc_get_template_html(var_template_name rt.PhpVal, var_args rt.PhpVal, template_path string, default_path string) rt.PhpVal {
	mut var_template_path := template_path
	mut var_default_path := default_path
	rt.call_function('ob_start', []rt.PhpVal{})
	wc_get_template(var_template_name.clone(), rt.create_array_from_native_map(var_args), template_path, default_path)
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn wc_locate_template(var_template_name rt.PhpVal, template_path string, default_path string) rt.PhpVal {
	mut var_template_path := template_path
	mut var_default_path := default_path
	mut var_cs_template := rt.new_null()
	mut var_template := rt.new_null()
	if !(var_template_path.len > 0 && var_template_path != '0') {
	var_template_path = (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str()
	}
	if !(var_default_path.len > 0 && var_default_path != '0') {
	var_default_path = (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates/'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_template_name.clone(), rt.new_string('product_cat')]))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_template_name.clone(), rt.new_string('product_tag')]))))) {
	var_cs_template = rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_template_name.clone()])
	var_template = rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: (rt.call_function('trailingslashit', [rt.new_string((var_template_path).str())])).str() + (var_cs_template).str() }, rt.ArrayItem{ key: none, val: var_cs_template }])])
	}
	if !rt.is_true(var_template) {
	var_template = rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: (rt.call_function('trailingslashit', [rt.new_string((var_template_path).str())])).str() + (var_template_name).str() }, rt.ArrayItem{ key: none, val: var_template_name }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) || rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) {
		if !rt.is_true(var_cs_template) {
		var_template = rt.new_string((var_default_path + (var_template_name).str()).str())
		} else {
		var_template = rt.new_string((var_default_path + (var_cs_template).str()).str())
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_locate_template'), var_template.clone(), var_template_name.clone(), rt.new_string((var_template_path).str()), rt.new_string((var_default_path).str())])
}

fn wc_set_template_cache(var_cache_key rt.PhpVal, var_template rt.PhpVal) {
	mut var_cached_templates := rt.new_null()
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_template.clone(), rt.new_string('woocommerce')])
	var_cached_templates = rt.call_function('wp_cache_get', [rt.new_string('cached_templates'), rt.new_string('woocommerce')])
	if rt.is_true(rt.new_bool(var_cached_templates.clone().is_array())) {
		var_cached_templates.array_push(var_cache_key.clone())
	} else {
	var_cached_templates = rt.create_array([rt.ArrayItem{ key: none, val: var_cache_key }])
	}
	rt.call_function('wp_cache_set', [rt.new_string('cached_templates'), var_cached_templates.clone(), rt.new_string('woocommerce')])
}

fn wc_clear_template_cache() {
	mut var_cached_templates := rt.new_null()
	mut var_cache_key := rt.new_null()
	var_cached_templates = rt.call_function('wp_cache_get', [rt.new_string('cached_templates'), rt.new_string('woocommerce')])
	if rt.is_true(rt.new_bool(var_cached_templates.clone().is_array())) {
		mut iter_3 := var_cached_templates.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_cache_key_shadow := item_3.val
			rt.call_function('wp_cache_delete', [var_cache_key_shadow.clone(), rt.new_string('woocommerce')])
		}
		rt.call_function('wp_cache_delete', [rt.new_string('cached_templates'), rt.new_string('woocommerce')])
	}
}

fn wc_clear_system_status_theme_info_cache() {
	rt.call_function('delete_transient', [rt.new_string('wc_system_status_theme_info')])
}

fn get_woocommerce_currency() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_currency'), rt.call_function('get_option', [rt.new_string('woocommerce_currency')])])
}

fn get_woocommerce_currencies() rt.PhpVal {
	mut var_currencies := rt.new_null()
	if !(!(var_currencies).is_null()) {
	var_currencies = rt.call_function('array_unique', [rt.call_function('apply_filters', [rt.new_string('woocommerce_currencies'), rt.include_file((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/i18n/currencies.php', '1')])])
	}
	return var_currencies.clone()
}

fn get_woocommerce_currency_symbols() rt.PhpVal {
	mut var_symbols := rt.new_null()
	var_symbols = rt.call_function('apply_filters', [rt.new_string('woocommerce_currency_symbols'), rt.create_array([rt.ArrayItem{ key: 'AED', val: '&#x62f;.&#x625;' }, rt.ArrayItem{ key: 'AFN', val: '&#x60b;' }, rt.ArrayItem{ key: 'ALL', val: 'L' }, rt.ArrayItem{ key: 'AMD', val: 'AMD' }, rt.ArrayItem{ key: 'ANG', val: '&fnof;' }, rt.ArrayItem{ key: 'AOA', val: 'Kz' }, rt.ArrayItem{ key: 'ARS', val: '&#36;' }, rt.ArrayItem{ key: 'AUD', val: '&#36;' }, rt.ArrayItem{ key: 'AWG', val: 'Afl.' }, rt.ArrayItem{ key: 'AZN', val: '&#8380;' }, rt.ArrayItem{ key: 'BAM', val: 'KM' }, rt.ArrayItem{ key: 'BBD', val: '&#36;' }, rt.ArrayItem{ key: 'BDT', val: '&#2547;&nbsp;' }, rt.ArrayItem{ key: 'BGN', val: '&#1083;&#1074;.' }, rt.ArrayItem{ key: 'BHD', val: '.&#x62f;.&#x628;' }, rt.ArrayItem{ key: 'BIF', val: 'Fr' }, rt.ArrayItem{ key: 'BMD', val: '&#36;' }, rt.ArrayItem{ key: 'BND', val: '&#36;' }, rt.ArrayItem{ key: 'BOB', val: 'Bs.' }, rt.ArrayItem{ key: 'BRL', val: '&#82;&#36;' }, rt.ArrayItem{ key: 'BSD', val: '&#36;' }, rt.ArrayItem{ key: 'BTC', val: '&#3647;' }, rt.ArrayItem{ key: 'BTN', val: 'Nu.' }, rt.ArrayItem{ key: 'BWP', val: 'P' }, rt.ArrayItem{ key: 'BYR', val: 'Br' }, rt.ArrayItem{ key: 'BYN', val: 'Br' }, rt.ArrayItem{ key: 'BZD', val: '&#36;' }, rt.ArrayItem{ key: 'CAD', val: '&#36;' }, rt.ArrayItem{ key: 'CDF', val: 'Fr' }, rt.ArrayItem{ key: 'CHF', val: '&#67;&#72;&#70;' }, rt.ArrayItem{ key: 'CLP', val: '&#36;' }, rt.ArrayItem{ key: 'CNY', val: '&yen;' }, rt.ArrayItem{ key: 'COP', val: '&#36;' }, rt.ArrayItem{ key: 'CRC', val: '&#x20a1;' }, rt.ArrayItem{ key: 'CUC', val: '&#36;' }, rt.ArrayItem{ key: 'CUP', val: '&#36;' }, rt.ArrayItem{ key: 'CVE', val: '&#36;' }, rt.ArrayItem{ key: 'CZK', val: '&#75;&#269;' }, rt.ArrayItem{ key: 'DJF', val: 'Fr' }, rt.ArrayItem{ key: 'DKK', val: 'kr.' }, rt.ArrayItem{ key: 'DOP', val: 'RD&#36;' }, rt.ArrayItem{ key: 'DZD', val: '&#x62f;.&#x62c;' }, rt.ArrayItem{ key: 'EGP', val: 'EGP' }, rt.ArrayItem{ key: 'ERN', val: 'Nfk' }, rt.ArrayItem{ key: 'ETB', val: 'Br' }, rt.ArrayItem{ key: 'EUR', val: '&euro;' }, rt.ArrayItem{ key: 'FJD', val: '&#36;' }, rt.ArrayItem{ key: 'FKP', val: '&pound;' }, rt.ArrayItem{ key: 'GBP', val: '&pound;' }, rt.ArrayItem{ key: 'GEL', val: '&#x20be;' }, rt.ArrayItem{ key: 'GGP', val: '&pound;' }, rt.ArrayItem{ key: 'GHS', val: '&#x20b5;' }, rt.ArrayItem{ key: 'GIP', val: '&pound;' }, rt.ArrayItem{ key: 'GMD', val: 'D' }, rt.ArrayItem{ key: 'GNF', val: 'Fr' }, rt.ArrayItem{ key: 'GTQ', val: 'Q' }, rt.ArrayItem{ key: 'GYD', val: '&#36;' }, rt.ArrayItem{ key: 'HKD', val: '&#36;' }, rt.ArrayItem{ key: 'HNL', val: 'L' }, rt.ArrayItem{ key: 'HRK', val: 'kn' }, rt.ArrayItem{ key: 'HTG', val: 'G' }, rt.ArrayItem{ key: 'HUF', val: '&#70;&#116;' }, rt.ArrayItem{ key: 'IDR', val: 'Rp' }, rt.ArrayItem{ key: 'ILS', val: '&#8362;' }, rt.ArrayItem{ key: 'IMP', val: '&pound;' }, rt.ArrayItem{ key: 'INR', val: '&#8377;' }, rt.ArrayItem{ key: 'IQD', val: '&#x62f;.&#x639;' }, rt.ArrayItem{ key: 'IRR', val: '&#xfdfc;' }, rt.ArrayItem{ key: 'IRT', val: '&#x062A;&#x0648;&#x0645;&#x0627;&#x0646;' }, rt.ArrayItem{ key: 'ISK', val: 'kr.' }, rt.ArrayItem{ key: 'JEP', val: '&pound;' }, rt.ArrayItem{ key: 'JMD', val: '&#36;' }, rt.ArrayItem{ key: 'JOD', val: '&#x62f;.&#x627;' }, rt.ArrayItem{ key: 'JPY', val: '&yen;' }, rt.ArrayItem{ key: 'KES', val: 'KSh' }, rt.ArrayItem{ key: 'KGS', val: '&#x441;&#x43e;&#x43c;' }, rt.ArrayItem{ key: 'KHR', val: '&#x17db;' }, rt.ArrayItem{ key: 'KMF', val: 'Fr' }, rt.ArrayItem{ key: 'KPW', val: '&#x20a9;' }, rt.ArrayItem{ key: 'KRW', val: '&#8361;' }, rt.ArrayItem{ key: 'KWD', val: '&#x62f;.&#x643;' }, rt.ArrayItem{ key: 'KYD', val: '&#36;' }, rt.ArrayItem{ key: 'KZT', val: '&#8376;' }, rt.ArrayItem{ key: 'LAK', val: '&#8365;' }, rt.ArrayItem{ key: 'LBP', val: '&#x644;.&#x644;' }, rt.ArrayItem{ key: 'LKR', val: '&#xdbb;&#xdd4;' }, rt.ArrayItem{ key: 'LRD', val: '&#36;' }, rt.ArrayItem{ key: 'LSL', val: 'L' }, rt.ArrayItem{ key: 'LYD', val: '&#x62f;.&#x644;' }, rt.ArrayItem{ key: 'MAD', val: '&#x62f;.&#x645;.' }, rt.ArrayItem{ key: 'MDL', val: 'MDL' }, rt.ArrayItem{ key: 'MGA', val: 'Ar' }, rt.ArrayItem{ key: 'MKD', val: '&#x434;&#x435;&#x43d;' }, rt.ArrayItem{ key: 'MMK', val: 'Ks' }, rt.ArrayItem{ key: 'MNT', val: '&#x20ae;' }, rt.ArrayItem{ key: 'MOP', val: 'P' }, rt.ArrayItem{ key: 'MRU', val: 'UM' }, rt.ArrayItem{ key: 'MUR', val: '&#x20a8;' }, rt.ArrayItem{ key: 'MVR', val: '.&#x783;' }, rt.ArrayItem{ key: 'MWK', val: 'MK' }, rt.ArrayItem{ key: 'MXN', val: '&#36;' }, rt.ArrayItem{ key: 'MYR', val: '&#82;&#77;' }, rt.ArrayItem{ key: 'MZN', val: 'MT' }, rt.ArrayItem{ key: 'NAD', val: 'N&#36;' }, rt.ArrayItem{ key: 'NGN', val: '&#8358;' }, rt.ArrayItem{ key: 'NIO', val: 'C&#36;' }, rt.ArrayItem{ key: 'NOK', val: '&#107;&#114;' }, rt.ArrayItem{ key: 'NPR', val: '&#8360;' }, rt.ArrayItem{ key: 'NZD', val: '&#36;' }, rt.ArrayItem{ key: 'OMR', val: '&#x631;.&#x639;.' }, rt.ArrayItem{ key: 'PAB', val: 'B/.' }, rt.ArrayItem{ key: 'PEN', val: 'S/' }, rt.ArrayItem{ key: 'PGK', val: 'K' }, rt.ArrayItem{ key: 'PHP', val: '&#8369;' }, rt.ArrayItem{ key: 'PKR', val: '&#8360;' }, rt.ArrayItem{ key: 'PLN', val: '&#122;&#322;' }, rt.ArrayItem{ key: 'PRB', val: '&#x440;.' }, rt.ArrayItem{ key: 'PYG', val: '&#8370;' }, rt.ArrayItem{ key: 'QAR', val: '&#x631;.&#x642;' }, rt.ArrayItem{ key: 'RMB', val: '&yen;' }, rt.ArrayItem{ key: 'RON', val: 'lei' }, rt.ArrayItem{ key: 'RSD', val: '&#1088;&#1089;&#1076;' }, rt.ArrayItem{ key: 'RUB', val: '&#8381;' }, rt.ArrayItem{ key: 'RWF', val: 'Fr' }, rt.ArrayItem{ key: 'SAR', val: '&#x631;.&#x633;' }, rt.ArrayItem{ key: 'SBD', val: '&#36;' }, rt.ArrayItem{ key: 'SCR', val: '&#x20a8;' }, rt.ArrayItem{ key: 'SDG', val: '&#x62c;.&#x633;.' }, rt.ArrayItem{ key: 'SEK', val: '&#107;&#114;' }, rt.ArrayItem{ key: 'SGD', val: '&#36;' }, rt.ArrayItem{ key: 'SHP', val: '&pound;' }, rt.ArrayItem{ key: 'SLL', val: 'Le' }, rt.ArrayItem{ key: 'SOS', val: 'Sh' }, rt.ArrayItem{ key: 'SRD', val: '&#36;' }, rt.ArrayItem{ key: 'SSP', val: '&pound;' }, rt.ArrayItem{ key: 'STN', val: 'Db' }, rt.ArrayItem{ key: 'SYP', val: '&#x644;.&#x633;' }, rt.ArrayItem{ key: 'SZL', val: 'E' }, rt.ArrayItem{ key: 'THB', val: '&#3647;' }, rt.ArrayItem{ key: 'TJS', val: '&#x405;&#x41c;' }, rt.ArrayItem{ key: 'TMT', val: 'm' }, rt.ArrayItem{ key: 'TND', val: '&#x62f;.&#x62a;' }, rt.ArrayItem{ key: 'TOP', val: 'T&#36;' }, rt.ArrayItem{ key: 'TRY', val: '&#8378;' }, rt.ArrayItem{ key: 'TTD', val: '&#36;' }, rt.ArrayItem{ key: 'TWD', val: '&#78;&#84;&#36;' }, rt.ArrayItem{ key: 'TZS', val: 'Sh' }, rt.ArrayItem{ key: 'UAH', val: '&#8372;' }, rt.ArrayItem{ key: 'UGX', val: 'UGX' }, rt.ArrayItem{ key: 'USD', val: '&#36;' }, rt.ArrayItem{ key: 'UYU', val: '&#36;' }, rt.ArrayItem{ key: 'UZS', val: 'UZS' }, rt.ArrayItem{ key: 'VEF', val: 'Bs F' }, rt.ArrayItem{ key: 'VES', val: 'Bs.' }, rt.ArrayItem{ key: 'VND', val: '&#8363;' }, rt.ArrayItem{ key: 'VUV', val: 'Vt' }, rt.ArrayItem{ key: 'WST', val: 'T' }, rt.ArrayItem{ key: 'XAF', val: 'CFA' }, rt.ArrayItem{ key: 'XCD', val: '&#36;' }, rt.ArrayItem{ key: 'XOF', val: 'CFA' }, rt.ArrayItem{ key: 'XPF', val: 'XPF' }, rt.ArrayItem{ key: 'YER', val: '&#xfdfc;' }, rt.ArrayItem{ key: 'ZAR', val: '&#82;' }, rt.ArrayItem{ key: 'ZMW', val: 'ZK' }])])
	return var_symbols.clone()
}

fn get_woocommerce_currency_symbol(currency string) rt.PhpVal {
	mut var_currency := currency
	mut var_symbols := rt.new_null()
	mut var_currency_symbol := rt.new_null()
	if !(var_currency.len > 0 && var_currency != '0') {
	var_currency = (get_woocommerce_currency()).str()
	}
	var_symbols = get_woocommerce_currency_symbols()
	var_currency_symbol = if var_symbols.array_isset(rt.new_string((var_currency).str())) { var_symbols.array_get(rt.new_string((var_currency).str())) } else { rt.new_string('') }
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_currency_symbol'), var_currency_symbol.clone(), rt.new_string((var_currency).str())])
}

fn wc_mail(var_to rt.PhpVal, var_subject rt.PhpVal, var_message rt.PhpVal, headers string, attachments string) rt.PhpVal {
	mut var_headers := headers
	mut var_attachments := attachments
	mut var_mailer := rt.new_null()
	var_mailer = rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{})
	return rt.call_method(var_mailer, 'send', [var_to.clone(), var_subject.clone(), var_message.clone(), rt.new_string(headers), rt.new_string(attachments)])
}

fn wc_get_theme_support(prop string, var_default rt.PhpVal) rt.PhpVal {
	mut var_prop := prop
	mut var_theme_support := rt.new_null()
	mut var_prop_stack := rt.new_null()
	mut var_prop_key := rt.new_null()
	mut var_value := rt.new_null()
	var_theme_support = rt.call_function('get_theme_support', [rt.new_string('woocommerce')])
	var_theme_support = if var_theme_support.clone().is_array() { var_theme_support.array_get(rt.new_int(0)) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_support)))) {
		return var_default.clone()
	}
	if var_prop.len > 0 && var_prop != '0' {
		var_prop_stack = rt.call_function('explode', [rt.new_string('::'), rt.new_string(prop)])
		var_prop_key = rt.call_function('array_shift', [var_prop_stack.clone()])
		if var_theme_support.array_isset(var_prop_key) {
			var_value = var_theme_support.array_get(var_prop_key)
			if rt.is_true(rt.new_int(var_prop_stack.clone().array_count())) {
				mut iter_4 := var_prop_stack.iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_prop_key_shadow := item_4.val
					if var_value.clone().is_array() && var_value.array_isset(var_prop_key_shadow) {
					var_value = var_value.array_get(var_prop_key_shadow)
					} else {
						var_value = var_default.clone()
						break
					}
				}
			}
		} else {
		var_value = var_default.clone()
		}
		return var_value.clone()
	}
	return var_theme_support.clone()
}

fn wc_get_image_size(var_image_size_arg rt.PhpVal) rt.PhpVal {
	mut var_image_size := var_image_size_arg
	mut var_cache_key := rt.new_null()
	mut var_size := rt.new_null()
	mut var_cropping := rt.new_null()
	mut var_width := rt.new_null()
	mut var_height := rt.new_null()
	mut var_cropping_split := rt.new_null()
	var_cache_key = rt.new_string('size-' + (if var_image_size.clone().is_array() { rt.call_function('implode', [rt.new_string('-'), var_image_size.clone()]) } else { var_image_size }).str())
	var_size = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) { rt.call_function('wp_cache_get', [var_cache_key.clone(), rt.new_string('woocommerce')]) } else { rt.new_bool(false) }
	if rt.is_true(var_size) {
		return var_size.clone()
	}
	var_size = rt.create_array([rt.ArrayItem{ key: 'width', val: 600 }, rt.ArrayItem{ key: 'height', val: 600 }, rt.ArrayItem{ key: 'crop', val: 1 }])
	if rt.is_true(rt.new_bool(var_image_size.clone().is_array())) {
	var_size = rt.create_array([rt.ArrayItem{ key: 'width', val: if var_image_size.array_isset(rt.new_int(0)) { rt.call_function('absint', [var_image_size.array_get(rt.new_int(0))]) } else { rt.new_int(600) } }, rt.ArrayItem{ key: 'height', val: if var_image_size.array_isset(rt.new_int(1)) { rt.call_function('absint', [var_image_size.array_get(rt.new_int(1))]) } else { rt.new_int(600) } }, rt.ArrayItem{ key: 'crop', val: if var_image_size.array_isset(rt.new_int(2)) { rt.call_function('absint', [var_image_size.array_get(rt.new_int(2))]) } else { rt.new_int(1) } }])
	var_image_size = rt.new_string((var_size.array_get(rt.new_string('width'))).str() + '_' + (var_size.array_get(rt.new_string('height'))).str())
	} else {
		var_image_size = rt.call_function('str_replace', [rt.new_string('woocommerce_'), rt.new_string(''), var_image_size.clone()])
		if rt.is_true(rt.identical(rt.new_string('single'), var_image_size)) {
			var_size.array_set('width', rt.call_function('absint', [wc_get_theme_support('single_image_width', rt.call_function('get_option', [rt.new_string('woocommerce_single_image_width'), rt.new_int(600)]))]))
			var_size.array_set('height', '')
			var_size.array_set('crop', 0)
		} else if rt.is_true(rt.identical(rt.new_string('gallery_thumbnail'), var_image_size)) {
			var_size.array_set('width', rt.call_function('absint', [wc_get_theme_support('gallery_thumbnail_image_width', rt.new_int(100))]))
			var_size.array_set('height', var_size.array_get(rt.new_string('width')))
			var_size.array_set('crop', 1)
		} else if rt.is_true(rt.identical(rt.new_string('thumbnail'), var_image_size)) {
			var_size.array_set('width', rt.call_function('absint', [wc_get_theme_support('thumbnail_image_width', rt.call_function('get_option', [rt.new_string('woocommerce_thumbnail_image_width'), rt.new_int(300)]))]))
			var_cropping = rt.call_function('get_option', [rt.new_string('woocommerce_thumbnail_cropping'), rt.new_string('1:1')])
			if rt.is_true(rt.identical(rt.new_string('uncropped'), var_cropping)) {
				var_size.array_set('height', '')
				var_size.array_set('crop', 0)
			} else if rt.is_true(rt.identical(rt.new_string('custom'), var_cropping)) {
				var_width = rt.call_function('max', [rt.new_int(1), rt.new_float((rt.call_function('get_option', [rt.new_string('woocommerce_thumbnail_cropping_custom_width'), rt.new_string('4')])).to_f64())])
				var_height = rt.call_function('max', [rt.new_int(1), rt.new_float((rt.call_function('get_option', [rt.new_string('woocommerce_thumbnail_cropping_custom_height'), rt.new_string('3')])).to_f64())])
				mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_4 := iife_temp_4.round(rt.mul(rt.div(var_size.array_get(rt.new_string('width')), var_width), var_height))
				mut iife_temp_5 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_5 := iife_temp_5.round(rt.mul(rt.div(var_size.array_get(rt.new_string('width')), var_width), var_height))
				var_size.array_set('height', rt.call_function('absint', [iife_result_4]))
				var_size.array_set('crop', 1)
			} else {
				var_cropping_split = rt.call_function('explode', [rt.new_string(':'), var_cropping.clone()])
				var_width = rt.call_function('max', [rt.new_int(1), rt.new_float((rt.call_function('current', [var_cropping_split.clone()])).to_f64())])
				var_height = rt.call_function('max', [rt.new_int(1), rt.new_float((rt.call_function('end', [var_cropping_split.clone()])).to_f64())])
				mut iife_temp_6 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_6 := iife_temp_6.round(rt.mul(rt.div(var_size.array_get(rt.new_string('width')), var_width), var_height))
				mut iife_temp_7 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				mut iife_result_7 := iife_temp_7.round(rt.mul(rt.div(var_size.array_get(rt.new_string('width')), var_width), var_height))
				var_size.array_set('height', rt.call_function('absint', [iife_result_6]))
				var_size.array_set('crop', 1)
			}
		}
	}
	var_size = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_image_size_' + (var_image_size).str()), var_size.clone()])
	if rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{})) {
		rt.call_function('wp_cache_delete', [var_cache_key.clone(), rt.new_string('woocommerce')])
	} else {
		rt.call_function('wp_cache_set', [var_cache_key.clone(), var_size.clone(), rt.new_string('woocommerce')])
	}
	return var_size.clone()
}

fn wc_enqueue_js(var_code rt.PhpVal) {
	mut var_wc_queued_js := ''
	rt.call_function('wc_deprecated_function', [rt.new_string('wc_enqueue_js'), rt.new_string('10.4.0'), rt.new_string('wp_add_inline_script')])
	if var_wc_queued_js == '' {
	var_wc_queued_js = ''
	}
	var_wc_queued_js = var_wc_queued_js + '\n' + (var_code).str() + '\n'
}

fn wc_print_js() {
	mut var_wc_queued_js := rt.new_null()
	mut var_js := ''
	if !(!rt.is_true(var_wc_queued_js)) {
		var_wc_queued_js = rt.call_function('wp_check_invalid_utf8', [var_wc_queued_js.clone()])
		var_wc_queued_js = rt.call_function('preg_replace', [rt.new_string('/&#(x)?0*(?(1)27|39);?/i'), rt.new_string('\''), var_wc_queued_js.clone()])
		var_wc_queued_js = rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string(''), var_wc_queued_js.clone()])
		var_js = rt.concat(rt.concat(rt.new_string('<!-- WooCommerce JavaScript -->\n<script type="text/javascript">\njQuery(function($) { '), var_wc_queued_js), rt.new_string(' });\n</script>\n'))
		rt.echo_val(rt.call_function('apply_filters', [rt.new_string('woocommerce_queued_js'), rt.new_string((var_js).str()).clone()]))
		var_wc_queued_js = rt.new_null()
	}
}

fn wc_setcookie(var_name rt.PhpVal, var_value rt.PhpVal, expire i64, secure bool, httponly bool) {
	mut var_expire := expire
	mut var_secure := secure
	mut var_httponly := httponly
	mut var_file := rt.new_null()
	mut var_line := rt.new_null()
	mut var_options := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_set_cookie_enabled'), rt.new_bool(true), var_name.clone(), var_value.clone(), rt.new_int(expire), rt.new_bool(secure)]))))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		var_options = rt.call_function('apply_filters', [rt.new_string('woocommerce_set_cookie_options'), rt.create_array([rt.ArrayItem{ key: 'expires', val: expire }, rt.ArrayItem{ key: 'secure', val: secure }, rt.ArrayItem{ key: 'path', val: if rt.is_true(rt.get_constant('COOKIEPATH')) { rt.get_constant('COOKIEPATH') } else { rt.new_string('/') } }, rt.ArrayItem{ key: 'domain', val: rt.get_constant('COOKIE_DOMAIN') }, rt.ArrayItem{ key: 'httponly', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_cookie_httponly'), rt.new_bool(httponly), var_name.clone(), var_value.clone(), rt.new_int(expire), rt.new_bool(secure)]) }]), var_name.clone(), var_value.clone()])
		rt.call_function('setcookie', [var_name.clone(), var_value.clone(), var_options.clone()])
	mut iife_temp_8 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_8 := iife_temp_8.is_true(rt.new_string('WP_DEBUG'))
	} else if rt.is_true(iife_result_8) {
		rt.call_function('headers_sent', [var_file.clone(), var_line.clone()])
		rt.call_function('trigger_error', [rt.new_string("${var_name.to_string()} cookie cannot be set - headers already sent by ${var_file.to_string()} on line ${var_line.to_string()}"), rt.get_constant('E_USER_NOTICE')])
	}
}

fn wc_get_page_children(var_page_id_arg rt.PhpVal) rt.PhpVal {
	mut var_page_id := var_page_id_arg
	mut var_page_ids := rt.new_null()
	var_page_ids = rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_parent', val: var_page_id }, rt.ArrayItem{ key: 'post_type', val: 'page' }, rt.ArrayItem{ key: 'numberposts', val: -1 }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'fields', val: 'ids' }])])
	if !(!rt.is_true(var_page_ids)) {
		mut iter_5 := var_page_ids.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_page_id_shadow := item_5.val
		var_page_ids = rt.call_function('array_merge', [var_page_ids.clone(), wc_get_page_children(var_page_id_shadow.clone())])
		}
	}
	return var_page_ids.clone()
}

fn flush_rewrite_rules_on_shop_page_save() {
	mut var_screen := rt.new_null()
	mut var_screen_id := rt.new_null()
	mut var_post_id := i64(0)
	mut var_shop_page_id := rt.new_null()
	var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_screen_id = if rt.is_true(var_screen) { rt.get_property(var_screen, 'id') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), var_screen_id)))) {
		return
	}
	if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('post'))) || !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('action'))) || (rt.get_superglobal('_GET').array_isset(rt.new_string('action')) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('edit'), rt.get_superglobal('_GET').array_get(rt.new_string('action'))))))) {
		return
	}
	var_post_id = rt.get_superglobal('_GET').array_get(rt.new_string('post')).to_i64()
	var_shop_page_id = rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	if rt.is_true(rt.identical(var_shop_page_id, rt.new_int(var_post_id))) || rt.is_true(rt.call_function('in_array', [rt.new_int(var_post_id).clone(), wc_get_page_children(var_shop_page_id.clone()), rt.new_bool(true)])) {
		rt.call_function('do_action', [rt.new_string('woocommerce_flush_rewrite_rules')])
	}
}

fn wc_fix_rewrite_rules(var_rules_arg rt.PhpVal) rt.PhpVal {
	mut var_rules := var_rules_arg
	mut var_wp_rewrite := rt.new_null()
	mut var_matches := rt.new_null()
	mut var_permalinks := rt.new_null()
	mut var_rewrite := rt.new_null()
	mut var_rule := rt.new_null()
	mut var_shop_page_id := rt.new_null()
	mut var_page_rewrite_rules := rt.new_null()
	mut var_subpages := rt.new_null()
	mut var_subpage := rt.new_null()
	mut var_uri := rt.new_null()
	mut var_wp_generated_rewrite_rules := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	var_permalinks = wc_get_permalink_structure()
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('`/(.+)(/%product_cat%)`'), var_permalinks.array_get(rt.new_string('product_rewrite_slug')), var_matches.clone()])) {
		mut iter_6 := var_rules.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_rewrite_shadow := item_6.val
			mut var_rule_shadow := item_6.key
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('`^' + (rt.call_function('preg_quote', [var_matches.array_get(rt.new_int(1)), rt.new_string('`')])).str() + '/\\(`'), var_rule_shadow.clone()])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(index\\.php\\?product_cat)(?!(.*product))/'), var_rewrite_shadow.clone()])) {
				var_rules.array_unset(var_rule_shadow)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_permalinks.array_get(rt.new_string('use_verbose_page_rules')))))) {
		return var_rules.clone()
	}
	var_shop_page_id = rt.call_function('wc_get_page_id', [rt.new_string('shop')])
	if rt.is_true(var_shop_page_id) {
		var_page_rewrite_rules = rt.new_array()
		var_subpages = wc_get_page_children(var_shop_page_id.clone())
		mut iter_7 := var_subpages.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_subpage_shadow := item_7.val
			var_uri = rt.call_function('get_page_uri', [var_subpage_shadow.clone()])
			var_page_rewrite_rules.array_set((var_uri).str() + '/?$', 'index.php?pagename=' + (var_uri).str())
			var_wp_generated_rewrite_rules = rt.call_method(var_wp_rewrite, 'generate_rewrite_rules', [var_uri.clone(), rt.get_constant('EP_PAGES'), rt.new_bool(true), rt.new_bool(true), rt.new_bool(false), rt.new_bool(false)])
			mut iter_8 := var_wp_generated_rewrite_rules.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_value_shadow := item_8.val
				mut var_key_shadow := item_8.key
				var_wp_generated_rewrite_rules.array_set(var_key_shadow, (var_value_shadow).str() + '&pagename=' + (var_uri).str())
			}
		var_page_rewrite_rules = rt.call_function('array_merge', [var_page_rewrite_rules.clone(), var_wp_generated_rewrite_rules.clone()])
		}
	var_rules = rt.call_function('array_merge', [var_page_rewrite_rules.clone(), var_rules.clone()])
	}
	return var_rules.clone()
}

fn wc_fix_product_attachment_link(var_link_arg rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_link := var_link_arg
	mut var_parent_type := rt.new_null()
	var_parent_type = rt.call_function('get_post_type', [rt.call_function('wp_get_post_parent_id', [var_post_id.clone()])])
	if rt.is_true(rt.identical(rt.new_string('product'), var_parent_type)) || rt.is_true(rt.identical(rt.new_string('product_variation'), var_parent_type)) {
	var_link = rt.call_function('home_url', [rt.new_string('/?attachment_id=' + (var_post_id).str())])
	}
	return var_link.clone()
}

fn wc_ms_protect_download_rewite_rules(var_rewrite rt.PhpVal) string {
	mut var_rule := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) || rt.is_true(rt.identical(rt.new_string('redirect'), rt.call_function('get_option', [rt.new_string('woocommerce_file_download_method')]))) {
		return (var_rewrite).str()
	}
	var_rule = '\n# WooCommerce Rules - Protect Files from ms-files.php\n\n'
	var_rule = var_rule + '<IfModule mod_rewrite.c>\n'
	var_rule = var_rule + 'RewriteEngine On\n'
	var_rule = var_rule + 'RewriteCond %{QUERY_STRING} file=woocommerce_uploads/ [NC]\n'
	var_rule = var_rule + 'RewriteRule /ms-files.php$ - [F]\n'
	var_rule = var_rule + '</IfModule>\n\n'
	return var_rule + (var_rewrite).str()
}

fn wc_format_country_state_string(var_country_string rt.PhpVal) rt.PhpVal {
	mut var_country := rt.new_null()
	mut var_state := ''
	if rt.is_true(rt.call_function('strstr', [var_country_string.clone(), rt.new_string(':')])) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'), var_country_string.clone()])
		var_country = (list_tmp_1).array_get(0)
		var_state = (list_tmp_1).array_get(1)
	} else {
	var_country = var_country_string
	var_state = ''
	}
	return rt.create_array([rt.ArrayItem{ key: 'country', val: var_country }, rt.ArrayItem{ key: 'state', val: var_state }])
}

fn wc_get_base_location() rt.PhpVal {
	mut var_default := rt.new_null()
	var_default = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_base_location'), rt.call_function('get_option', [rt.new_string('woocommerce_default_country'), rt.new_string('US:CA')])])
	return wc_format_country_state_string(var_default.clone())
}

fn wc_get_customer_geolocation(var_fallback rt.PhpVal) rt.PhpVal {
	mut var_ua := rt.new_null()
	mut var_geolocation := rt.new_null()
	mut var_allowed_countries := rt.new_null()
	mut var_allowed_states := rt.new_null()
	mut var_country_states := rt.new_null()
	var_ua = wc_get_user_agent()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_ua.clone(), rt.new_string('bot')]), rt.new_bool(false))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_ua.clone(), rt.new_string('spider')]), rt.new_bool(false))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_ua.clone(), rt.new_string('crawl')]), rt.new_bool(false))))) {
		return var_fallback.clone()
	}
	mut iife_temp_9 := Class_WC_Geolocation{}
	mut iife_result_9 := iife_temp_9.geolocate_ip(rt.new_string(''), rt.new_bool(true), rt.new_bool(false))
	var_geolocation = iife_result_9
	if !rt.is_true(var_geolocation.array_get(rt.new_string('country'))) {
		return var_fallback.clone()
	}
	var_allowed_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	if !(var_allowed_countries.array_isset(var_geolocation.array_get(rt.new_string('country')))) {
		return var_fallback.clone()
	}
	var_allowed_states = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_country_states', []rt.PhpVal{})
	var_country_states = if !(var_allowed_states.array_get(var_geolocation.array_get(rt.new_string('country')))).is_null() { var_allowed_states.array_get(var_geolocation.array_get(rt.new_string('country'))) } else { rt.new_array() }
	if rt.is_true(var_country_states) && !(var_country_states.array_isset(var_geolocation.array_get(rt.new_string('state')))) {
		var_geolocation.array_set('state', '')
	}
	return rt.create_array([rt.ArrayItem{ key: 'country', val: var_geolocation.array_get(rt.new_string('country')) }, rt.ArrayItem{ key: 'state', val: var_geolocation.array_get(rt.new_string('state')) }])
}

fn wc_get_customer_default_location() rt.PhpVal {
	mut var_set_default_location_to := rt.new_null()
	mut var_default_location_string := rt.new_null()
	mut var_default_location := rt.new_null()
	mut var_allowed_countries := rt.new_null()
	var_set_default_location_to = rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address'), Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.base()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.no_default(), var_set_default_location_to)))) {
	var_default_location_string = rt.call_function('get_option', [rt.new_string('woocommerce_default_country'), rt.new_string('US:CA')])
	}
	var_default_location = wc_format_country_state_string(rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_default_location'), if !(var_default_location_string).is_null() { var_default_location_string } else { rt.new_string('') }]))
	var_allowed_countries = rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_allowed_countries', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_default_location.array_get(rt.new_string('country')), rt.func_array_keys(var_allowed_countries.clone()), rt.new_bool(true)]))))) {
	var_default_location = rt.create_array([rt.ArrayItem{ key: 'country', val: '' }, rt.ArrayItem{ key: 'state', val: '' }])
	}
	if rt.is_true(rt.call_function('in_array', [var_set_default_location_to.clone(), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax() }]), rt.new_bool(true)])) {
	var_default_location = wc_get_customer_geolocation(var_default_location.clone())
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_customer_default_location_array'), var_default_location.clone()])
}

fn wc_get_user_agent() rt.PhpVal {
	return if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))])]) } else { rt.new_string('') }
	return rt.new_null()
}

fn wc_rand_hash(prefix string, var_max_length rt.PhpVal) string {
	mut var_prefix := prefix
	mut var_random := rt.new_null()
	mut var_e := rt.new_null()
	var_random = rt.call_function('bin2hex', [rt.call_function('random_bytes', [rt.new_int(20)])])
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		var_e = var_e_2.clone()
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_fast_hash')])) {
		var_random = rt.call_function('bin2hex', [rt.call_function('substr', [rt.call_function('wp_fast_hash', [rt.call_function('wp_rand', []rt.PhpVal{})]), rt.new_int(-20)])])
		} else {
		var_random = rt.call_function('bin2hex', [rt.call_function('substr', [rt.new_string(sha1.hexhash(rt.call_function('wp_rand', []rt.PhpVal{}).to_string())), rt.new_int(-20)])])
		}
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	if rt.is_true(var_max_length) && rt.is_true(rt.greater(var_max_length, rt.new_int(0))) {
	var_random = rt.call_function('substr', [var_random.clone(), rt.new_int(0), var_max_length.clone()])
	}
	return prefix + (var_random).str()
}

fn wc_api_hash(var_data rt.PhpVal) rt.PhpVal {
	return rt.call_function('hash_hmac', [rt.new_string('sha256'), var_data.clone(), rt.new_string('wc-api')])
}

fn wc_array_cartesian(var_input_arg rt.PhpVal) rt.PhpVal {
	mut var_input := var_input_arg
	mut var_results := rt.new_null()
	mut var_indexes := rt.new_null()
	mut var_index := i64(0)
	mut var_values := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_result := rt.new_null()
	mut var_result_key := rt.new_null()
	mut var_new_combination := rt.new_null()
	mut var_converted_values := rt.new_null()
	var_input = rt.call_function('array_filter', [var_input.clone()])
	var_results = rt.new_array()
	var_indexes = rt.new_array()
	var_index = 0
	mut iter_9 := var_input.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_values_shadow := item_9.val
		mut var_key_shadow := item_9.key
		mut iter_10 := var_values_shadow.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value_shadow := item_10.val
			var_indexes.array_get_mut(var_key_shadow).array_set(var_value_shadow, rt.post_inc(rt.new_int(var_index)))
		}
	}
	mut iter_11 := var_indexes.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_values_shadow := item_11.val
		mut var_key_shadow := item_11.key
		if !rt.is_true(var_results) {
			mut iter_12 := var_values_shadow.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_value_shadow := item_12.val
				var_results.array_push(rt.create_array([rt.ArrayItem{ key: var_key_shadow, val: var_value_shadow }]))
			}
		} else {
			mut iter_13 := var_results.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_result_shadow := item_13.val
				mut var_result_key_shadow := item_13.key
				mut iter_14 := var_values_shadow.iterator()
				for {
					item_14 := iter_14.next() or { break }
					mut var_value_shadow := item_14.val
					if !(var_results.array_get(var_result_key_shadow).array_isset(var_key_shadow)) {
						var_results.array_get_mut(var_result_key_shadow).array_set(var_key_shadow, var_value_shadow.clone())
					} else {
						var_new_combination = var_results.array_get(var_result_key_shadow)
						var_new_combination.array_set(var_key_shadow, var_value_shadow.clone())
						var_results.array_push(var_new_combination.clone())
					}
				}
			}
		}
	}
	rt.call_function('arsort', [var_results.clone()])
	mut iter_15 := var_results.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_result_shadow := item_15.val
		mut var_result_key_shadow := item_15.key
		var_converted_values = rt.new_array()
		rt.call_function('arsort', [var_results.array_get(var_result_key_shadow)])
		mut iter_16 := var_results.array_get(var_result_key_shadow).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_value_shadow := item_16.val
			mut var_key_shadow := item_16.key
			var_converted_values.array_set(var_key_shadow, rt.call_function('array_search', [var_value_shadow.clone(), var_indexes.array_get(var_key_shadow), rt.new_bool(true)]))
		}
		var_results.array_set(var_result_key_shadow, var_converted_values.clone())
	}
	return var_results.clone()
}

fn wc_transaction_query(type string, force bool) {
	mut var_type := type
	mut var_force := force
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	wc_maybe_define_constant('WC_USE_TRANSACTIONS', true)
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 := iife_temp_10.is_true(rt.new_string('WC_USE_TRANSACTIONS'))
	if rt.is_true(iife_result_10) || var_force {
		mut switch_val_1 := rt.new_string(type)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('commit'))) {
			rt.call_method(var_wpdb, 'query', [rt.new_string('COMMIT')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rollback'))) {
			rt.call_method(var_wpdb, 'query', [rt.new_string('ROLLBACK')])
		} else {
			rt.call_method(var_wpdb, 'query', [rt.new_string('START TRANSACTION')])
		}
	}
}

fn wc_get_cart_url() rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_cart_url := rt.new_null()
	mut iife_temp_11 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_11 := iife_temp_11.is_cart_page()
	if rt.is_true(iife_result_11) {
	var_cart_url = rt.call_function('get_permalink', [rt.get_property(var_post, 'ID')])
	} else {
	var_cart_url = rt.call_function('wc_get_page_permalink', [rt.new_string('cart')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_cart_url'), var_cart_url.clone()])
}

fn wc_get_checkout_url() rt.PhpVal {
	mut var_checkout_url := rt.new_null()
	var_checkout_url = rt.call_function('wc_get_page_permalink', [rt.new_string('checkout')])
	if rt.is_true(var_checkout_url) {
		if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) || rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_force_ssl_checkout')]))) {
		var_checkout_url = rt.call_function('str_replace', [rt.new_string('http:'), rt.new_string('https:'), var_checkout_url.clone()])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_checkout_url'), var_checkout_url.clone()])
}

fn woocommerce_register_shipping_method(var_shipping_method rt.PhpVal) {
	rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'register_shipping_method', [var_shipping_method.clone()])
}

fn wc_get_shipping_zone(var_package rt.PhpVal) rt.PhpVal {
	mut iife_temp_12 := Class_WC_Shipping_Zones{}
	mut iife_result_12 := iife_temp_12.get_zone_matching_package(var_package.clone())
	return iife_result_12
}

fn wc_get_credit_card_type_label(var_type_arg rt.PhpVal) rt.PhpVal {
	mut var_type := var_type_arg
	mut var_labels := rt.new_null()
	var_type = rt.new_string(var_type.clone().to_string().to_lower())
	var_type = rt.call_function('str_replace', [rt.new_string('-'), rt.new_string(' '), var_type.clone()])
	var_type = rt.call_function('str_replace', [rt.new_string('_'), rt.new_string(' '), var_type.clone()])
	var_labels = rt.call_function('apply_filters', [rt.new_string('woocommerce_credit_card_type_labels'), rt.create_array([rt.ArrayItem{ key: 'mastercard', val: rt.call_function('_x', [rt.new_string('MasterCard'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'visa', val: rt.call_function('_x', [rt.new_string('Visa'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'discover', val: rt.call_function('_x', [rt.new_string('Discover'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'american express', val: rt.call_function('_x', [rt.new_string('American Express'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'cartes bancaires', val: rt.call_function('_x', [rt.new_string('Cartes Bancaires'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'diners', val: rt.call_function('_x', [rt.new_string('Diners'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'jcb', val: rt.call_function('_x', [rt.new_string('JCB'), rt.new_string('Name of credit card'), rt.new_string('woocommerce')]) }])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_credit_card_type_label'), if rt.is_true(rt.new_bool(var_labels.clone().array_isset(var_type.clone()))) { var_labels.array_get(var_type) } else { rt.call_function('ucwords', [var_type.clone()]) }])
}

fn wc_back_link(var_label rt.PhpVal, var_url rt.PhpVal) {
	print('<small class="wc-admin-breadcrumb"><a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr', [var_label.clone()])).str() + '">&#x2934;&#xfe0e;</a></small>')
}

fn wc_back_header(var_title rt.PhpVal, var_label rt.PhpVal, var_url rt.PhpVal) {
	mut var_arrow := ''
	var_arrow = if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'dashicons-arrow-right-alt2' } else { 'dashicons-arrow-left-alt2' }
	print('<h2 class="wc-admin-header">')
	print('<small><a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() + '" aria-label="' + (rt.call_function('esc_attr', [var_label.clone()])).str() + '"><span class="dashicons ' + (rt.call_function('esc_attr', [rt.new_string((var_arrow).str()).clone()])).str() + '" aria-hidden="true"></span></a></small>')
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	print('</h2>')
}

fn wc_help_tip(var_tip rt.PhpVal, allow_html bool) rt.PhpVal {
	mut var_allow_html := allow_html
	mut var_sanitized_tip := rt.new_null()
	mut var_aria_label := rt.new_null()
	if var_allow_html {
	var_sanitized_tip = rt.call_function('wc_sanitize_tooltip', [var_tip.clone()])
	} else {
	var_sanitized_tip = rt.call_function('esc_attr', [var_tip.clone()])
	}
	var_aria_label = rt.call_function('wp_strip_all_tags', [var_tip.clone()])
	return rt.call_function('apply_filters', [rt.new_string('wc_help_tip'), rt.new_string('<span class="woocommerce-help-tip" tabindex="0" aria-label="' + (rt.call_function('esc_attr', [var_aria_label.clone()])).str() + '" data-tip="' + (var_sanitized_tip).str() + '"></span>'), var_sanitized_tip.clone(), var_tip.clone(), rt.new_bool(allow_html)])
}

fn wc_get_wildcard_postcodes(var_postcode rt.PhpVal, country string) rt.PhpVal {
	mut var_country := country
	mut var_formatted_postcode := rt.new_null()
	mut var_length := rt.new_null()
	mut var_postcodes := []rt.PhpVal{}
	mut var_i := i64(0)
	var_formatted_postcode = rt.call_function('wc_format_postcode', [var_postcode.clone(), rt.new_string(country)])
	var_length = if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strlen')])) { rt.call_function('mb_strlen', [var_formatted_postcode.clone()]) } else { rt.new_int(var_formatted_postcode.clone().to_string().len) }
	var_postcodes = [var_postcode, var_formatted_postcode, (var_formatted_postcode).str() + '*']
	var_i = 0
	for {
		if !(rt.is_true(rt.less(rt.new_int(var_i), var_length))) { break }
		var_postcodes << (if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_substr')])) { rt.call_function('mb_substr', [var_formatted_postcode.clone(), rt.new_int(0), rt.new_int(var_i + 1 * -1)]) } else { rt.call_function('substr', [var_formatted_postcode.clone(), rt.new_int(0), rt.new_int(var_i + 1 * -1)]) }).str() + '*'
		var_i += 1
	}
	return var_postcodes.clone()
}

fn wc_postcode_location_matcher(var_postcode_arg rt.PhpVal, var_objects rt.PhpVal, var_object_id_key rt.PhpVal, var_object_compare_key rt.PhpVal, country string) rt.PhpVal {
	mut var_country := country
	mut var_postcode := var_postcode_arg
	mut var_wildcard_postcodes := rt.new_null()
	mut var_matches := rt.new_null()
	mut var_object := rt.new_null()
	mut var_object_id := rt.new_null()
	mut var_compare_against := rt.new_null()
	mut var_range := rt.new_null()
	mut var_compare := rt.new_null()
	mut var_min := rt.new_null()
	mut var_max := rt.new_null()
	var_postcode = rt.call_function('wc_normalize_postcode', [var_postcode.clone()])
	var_wildcard_postcodes = rt.call_function('array_map', [rt.new_string('wc_clean'), wc_get_wildcard_postcodes(var_postcode.clone(), country)])
	var_matches = rt.new_array()
	mut iter_17 := var_objects.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_object_shadow := item_17.val
		var_object_id = rt.get_property(var_object_shadow, '{"nodeType":"Expr_Variable","line":1603,"name":"object_id_key"}')
		var_compare_against = rt.get_property(var_object_shadow, '{"nodeType":"Expr_Variable","line":1604,"name":"object_compare_key"}')
		if rt.is_true(rt.call_function('strstr', [var_compare_against.clone(), rt.new_string('...')])) {
			var_range = rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string('...'), var_compare_against.clone()])])
			if rt.is_true(rt.new_bool(2 != var_range.clone().array_count())) {
				continue
			}
			mut list_tmp_2 := var_range
			var_min = (list_tmp_2).array_get(0)
			var_max = (list_tmp_2).array_get(1)
			if !(var_min.clone().is_long() || var_min.clone().is_double()) || !(var_max.clone().is_long() || var_max.clone().is_double()) {
			var_compare = rt.call_function('wc_make_numeric_postcode', [var_postcode.clone()])
			var_min = rt.call_function('str_pad', [rt.call_function('wc_make_numeric_postcode', [var_min.clone()]), rt.new_int(var_compare.clone().to_string().len), rt.new_string('0')])
			var_max = rt.call_function('str_pad', [rt.call_function('wc_make_numeric_postcode', [var_max.clone()]), rt.new_int(var_compare.clone().to_string().len), rt.new_string('0')])
			} else {
			var_compare = var_postcode.clone()
			}
			if rt.is_true(rt.greater_equal(var_compare, var_min)) && rt.is_true(rt.less_equal(var_compare, var_max)) {
				var_matches.array_set(var_object_id, if var_matches.array_isset(var_object_id) { var_matches.array_get(var_object_id) } else { rt.new_array() })
				var_matches.array_get_mut(var_object_id).array_push(var_compare_against.clone())
			}
		} else if rt.is_true(rt.call_function('in_array', [var_compare_against.clone(), var_wildcard_postcodes.clone(), rt.new_bool(true)])) {
			var_matches.array_set(var_object_id, if var_matches.array_isset(var_object_id) { var_matches.array_get(var_object_id) } else { rt.new_array() })
			var_matches.array_get_mut(var_object_id).array_push(var_compare_against.clone())
		}
	}
	return var_matches.clone()
}

fn wc_get_shipping_method_count(include_legacy bool, enabled_only bool) rt.PhpVal {
	mut var_include_legacy := include_legacy
	mut var_enabled_only := enabled_only
	mut var_wpdb := rt.new_null()
	mut var_transient_name := ''
	mut var_transient_version := rt.new_null()
	mut var_transient_value := rt.new_null()
	mut var_counts := rt.new_null()
	mut var_methods := rt.new_null()
	mut var_method_ids := []rt.PhpVal{}
	mut var_method := rt.new_null()
	mut var_return := rt.new_null()
	var_transient_name = 'wc_shipping_method_count'
	mut iife_temp_13 := Class_WC_Cache_Helper{}
	mut iife_result_13 := iife_temp_13.get_transient_version(rt.new_string('shipping'))
	var_transient_version = iife_result_13
	var_transient_value = rt.call_function('get_transient', [rt.new_string((var_transient_name).str()).clone()])
	var_counts = rt.create_array([rt.ArrayItem{ key: 'legacy', val: 0 }, rt.ArrayItem{ key: 'enabled', val: 0 }, rt.ArrayItem{ key: 'disabled', val: 0 }])
	if (!(var_transient_value.array_isset(rt.new_string('legacy')) && var_transient_value.array_isset(rt.new_string('enabled')) && var_transient_value.array_isset(rt.new_string('disabled')) && var_transient_value.array_isset(rt.new_string('version')))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_transient_value.array_get(rt.new_string('version')), var_transient_version)))) {
		var_methods = rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'shipping', []rt.PhpVal{}), 'get_shipping_methods', []rt.PhpVal{})
		var_method_ids = rt.new_array()
		mut iter_18 := var_methods.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_method_shadow := item_18.val
			var_method_ids << rt.get_property(var_method_shadow, 'id')
			if !(rt.get_property(var_method_shadow, 'enabled')).is_null() && rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_method_shadow, 'enabled'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_method_shadow, 'supports', [rt.new_string('shipping-zones')]))))) {
				rt.pre_inc(var_counts.array_get(rt.new_string('legacy')))
			}
		}
		var_counts.array_set('enabled', rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods WHERE is_enabled=1 AND method_id IN (\'')) + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.create_array_from_list(var_method_ids)])])).str() + '\')').str())])]))
		var_counts.array_set('disabled', rt.call_function('absint', [rt.call_method(var_wpdb, 'get_var', [rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT COUNT(*) FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zone_methods WHERE is_enabled=0 AND method_id IN (\'')) + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.create_array_from_list(var_method_ids)])])).str() + '\')').str())])]))
		var_transient_value = rt.create_array([rt.ArrayItem{ key: 'version', val: var_transient_version }, rt.ArrayItem{ key: 'legacy', val: var_counts.array_get(rt.new_string('legacy')) }, rt.ArrayItem{ key: 'enabled', val: var_counts.array_get(rt.new_string('enabled')) }, rt.ArrayItem{ key: 'disabled', val: var_counts.array_get(rt.new_string('disabled')) }])
		rt.call_function('set_transient', [rt.new_string((var_transient_name).str()).clone(), var_transient_value.clone(), rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	} else {
	var_counts = var_transient_value.clone()
	}
	var_return = rt.new_int(0)
	if var_enabled_only {
	var_return = var_counts.array_get(rt.new_string('enabled'))
	} else {
	var_return = rt.add(var_counts.array_get(rt.new_string('enabled')), var_counts.array_get(rt.new_string('disabled')))
	}
	if var_include_legacy {
		var_return = rt.add(var_return, var_counts.array_get(rt.new_string('legacy')))
	}
	return var_return.clone()
}

fn wc_set_time_limit(limit i64) {
	mut var_limit := limit
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('set_time_limit')])) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.call_function('ini_get', [rt.new_string('disable_functions')]), rt.new_string('set_time_limit')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ini_get', [rt.new_string('safe_mode')]))))) {
		rt.call_function('set_time_limit', [rt.new_int(limit)])
	}
}

fn wc_nocache_headers() {
	mut iife_temp_14 := Class_WC_Cache_Helper{}
	mut iife_result_14 := iife_temp_14.set_nocache_constants()
	rt.call_function('nocache_headers', []rt.PhpVal{})
}

fn wc_product_attribute_uasort_comparison(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	mut var_a_position := rt.new_null()
	mut var_b_position := rt.new_null()
	var_a_position = if var_a.clone().is_null() { rt.new_null() } else { var_a.array_get(rt.new_string('position')) }
	var_b_position = if var_b.clone().is_null() { rt.new_null() } else { var_b.array_get(rt.new_string('position')) }
	return rt.new_int(wc_uasort_comparison(var_a_position.clone(), var_b_position.clone()))
}

fn wc_shipping_zone_method_order_uasort_comparison(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.new_int(wc_uasort_comparison(rt.get_property(var_a, 'method_order'), rt.get_property(var_b, 'method_order')))
}

fn wc_checkout_fields_uasort_comparison(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if !(var_a.array_isset(rt.new_string('priority')) && var_b.array_isset(rt.new_string('priority'))) {
		return 0
	}
	return wc_uasort_comparison(var_a.array_get(rt.new_string('priority')), var_b.array_get(rt.new_string('priority')))
}

fn wc_uasort_comparison(var_a rt.PhpVal, var_b rt.PhpVal) i64 {
	if rt.is_true(rt.identical(var_a, var_b)) {
		return 0
	}
	return if rt.is_true(rt.less(var_a, var_b)) { -1 } else { 1 }
}

fn wc_ascii_uasort_comparison(var_a_arg rt.PhpVal, var_b_arg rt.PhpVal) rt.PhpVal {
	mut var_a := var_a_arg
	mut var_b := var_b_arg
	var_a = rt.call_function('remove_accents', [var_a.clone()])
	var_b = rt.call_function('remove_accents', [var_b.clone()])
	return rt.call_function('strcmp', [var_a.clone(), var_b.clone()])
}

fn wc_asort_by_locale(var_data rt.PhpVal, locale string) rt.PhpVal {
	mut var_locale := locale
	mut var_collator := rt.new_null()
	mut var_e := rt.new_null()
	mut var_raw_data := rt.new_null()
	mut var_val := rt.new_null()
	mut var_key := rt.new_null()
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Collator')])) {
		var_locale = (if var_locale.len > 0 && var_locale != '0' { rt.new_string((var_locale).str()) } else { rt.call_function('get_locale', []rt.PhpVal{}) }).str()
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_collator = create_collator(rt.new_string((var_locale).str()))
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		var_collator.asort(var_data.clone(), Class_Collator.sort_string())
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		return var_data.clone()
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'IntlException') {
			var_e = var_e_3.clone()
			mut iife_temp_15 := Class_Automattic_Jetpack_Constants{}
			mut iife_result_15 := iife_temp_15.is_true(rt.new_string('WP_DEBUG'))
			if rt.is_true(iife_result_15) {
				rt.call_function('error_log', [rt.call_function('sprintf', [rt.new_string('An unexpected error occurred while trying to use PHP Intl Collator class, it may be caused by an incorrect installation of PHP Intl and ICU, and could be fixed by reinstallaing PHP Intl, see more details about PHP Intl installation: %1$s. Error message: %2$s'), rt.new_string('https://www.php.net/manual/en/intl.installation.php'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})])])
			}
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
	}
	var_raw_data = var_data.clone()
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_value = rt.call_function('remove_accents', [rt.call_function('html_entity_decode', [var_value.clone()])])
		return rt.new_null()
		}
	rt.call_function('array_walk', [var_data.clone(), rt.new_closure(closure_17_fn)])
	rt.call_function('uasort', [var_data.clone(), rt.new_string('strcmp')])
	mut iter_19 := var_data.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_val_shadow := item_19.val
		mut var_key_shadow := item_19.key
		var_data.array_set(var_key_shadow, var_raw_data.array_get(var_key_shadow))
	}
	return var_data.clone()
}

fn wc_get_tax_rounding_mode() i64 {
	mut var_constant := rt.new_null()
	var_constant = rt.get_constant('WC_TAX_ROUNDING_MODE')
	if rt.is_true(rt.identical(rt.new_string('auto'), var_constant)) {
		return (if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax'), rt.new_string('no')]))) { rt.get_constant('PHP_ROUND_HALF_DOWN') } else { rt.get_constant('PHP_ROUND_HALF_UP') }).to_i64()
	}
	return var_constant.clone().to_i64()
}

fn wc_get_rounding_precision() rt.PhpVal {
	mut var_precision := rt.new_null()
	var_precision = rt.add(rt.call_function('wc_get_price_decimals', []rt.PhpVal{}), rt.new_int(2))
	if rt.is_true(rt.less(var_precision, rt.call_function('absint', [rt.get_constant('WC_ROUNDING_PRECISION')]))) {
	var_precision = rt.call_function('absint', [rt.get_constant('WC_ROUNDING_PRECISION')])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_internal_rounding_precision'), var_precision.clone()])
}

fn wc_add_number_precision(var_value rt.PhpVal, round bool) f64 {
	mut var_round := round
	mut var_result := rt.new_null()
	mut var_round_precision := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
		return 0
	}
	var_result = rt.mul(var_value, rt.call_function('pow', [rt.new_int(10), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})]))
	var_round_precision = if var_round { rt.sub(wc_get_rounding_precision(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})) } else { wc_get_rounding_precision() }
	mut iife_temp_17 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_17 := iife_temp_17.round(var_result.clone(), var_round_precision.clone())
	return (iife_result_17).to_f64()
}

fn wc_remove_number_precision(var_value rt.PhpVal) f64 {
	mut var_cent_precision := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
		return 0
	}
	var_cent_precision = rt.call_function('pow', [rt.new_int(10), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
	return (rt.div(var_value, var_cent_precision)).to_f64()
}

fn wc_add_number_precision_deep(var_value rt.PhpVal, round bool) f64 {
	mut var_round := round
	mut var_sub_value := rt.new_null()
	mut var_key := rt.new_null()
	if !(var_value.clone().is_array()) {
		return wc_add_number_precision(rt.new_float((var_value).to_f64()), round)
	}
	mut iter_20 := var_value.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_sub_value_shadow := item_20.val
		mut var_key_shadow := item_20.key
		var_value.array_set(var_key_shadow, wc_add_number_precision_deep(var_sub_value_shadow.clone(), round))
	}
	return (var_value).to_f64()
}

fn wc_remove_number_precision_deep(var_value rt.PhpVal) f64 {
	mut var_sub_value := rt.new_null()
	mut var_key := rt.new_null()
	if !(var_value.clone().is_array()) {
		return wc_remove_number_precision(var_value.clone())
	}
	mut iter_21 := var_value.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_sub_value_shadow := item_21.val
		mut var_key_shadow := item_21.key
		var_value.array_set(var_key_shadow, wc_remove_number_precision_deep(var_sub_value_shadow.clone()))
	}
	return (var_value).to_f64()
}

fn wc_get_logger() rt.PhpVal {
	mut var_class := rt.new_null()
	mut var_implements := rt.new_null()
	mut var_logger := rt.new_null()
	var_class = rt.call_function('apply_filters', [rt.new_string('woocommerce_logging_class'), rt.new_string('WC_Logger')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_logger)))) && var_class.clone().is_string() && rt.is_true(rt.call_function('is_a', [var_logger.clone(), var_class.clone()])) {
		return var_logger.clone()
	}
	var_implements = rt.call_function('class_implements', [var_class.clone()])
	if var_implements.clone().is_array() && rt.is_true(rt.call_function('in_array', [rt.new_string('WC_Logger_Interface'), var_implements.clone(), rt.new_bool(true)])) {
	var_logger = if var_class.clone().is_object() { var_class } else { rt.create_object_dynamically(var_class, []rt.PhpVal{}) }
	} else {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The class %1$s provided by %2$s filter must implement %3$s.'), rt.new_string('woocommerce')]), rt.new_string('<code>' + (rt.call_function('esc_html', [if var_class.clone().is_object() { rt.call_function('get_class', [var_class.clone()]) } else { var_class }])).str() + '</code>'), rt.new_string('<code>woocommerce_logging_class</code>'), rt.new_string('<code>WC_Logger_Interface</code>')]), rt.new_string('3.0')])
	var_logger = if rt.is_true(rt.call_function('is_a', [var_logger.clone(), rt.new_string('WC_Logger')])) { var_logger } else { create_wc_logger() }
	}
	return var_logger.clone()
}

fn wc_cleanup_logs() {
	mut var_logger := rt.new_null()
	var_logger = wc_get_logger()
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_logger }, rt.ArrayItem{ key: none, val: 'clear_expired_logs' }])])) {
		rt.call_method(var_logger, 'clear_expired_logs', []rt.PhpVal{})
	}
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Logging_OrderLogsCleanupHelper.class()]), 'cleanup', []rt.PhpVal{})
}

fn wc_print_r(var_expression rt.PhpVal, return bool) bool {
	mut var_return := return
	mut var_alternatives := rt.new_null()
	mut var_alternative := map[string]rt.PhpVal{}
	mut var_res := rt.new_null()
	var_alternatives = rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'func', val: 'print_r' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'func', val: 'var_export' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: var_expression }, rt.ArrayItem{ key: none, val: true }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'func', val: 'json_encode' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: var_expression }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'func', val: 'serialize' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: var_expression }]) }]) }])
	var_alternatives = rt.call_function('apply_filters', [rt.new_string('woocommerce_print_r_alternatives'), var_alternatives.clone(), var_expression.clone()])
	mut iter_22 := var_alternatives.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_alternative_shadow := item_22.val
		if rt.is_true(rt.call_function('function_exists', [var_alternative_shadow['func']])) {
			var_res = rt.call_callable(var_alternative_shadow['func'], [var_alternative_shadow['args']])
			if var_return {
				return (var_res).to_bool()
			}
			rt.echo_val(var_res)
			return true
		}
	}
	return false
}

fn wc_list_pluck(var_list rt.PhpVal, var_callback_or_field rt.PhpVal, var_index_key rt.PhpVal) rt.PhpVal {
	mut var_first_el := rt.new_null()
	mut var_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_newlist := rt.new_null()
	var_first_el = rt.call_function('current', [var_list.clone()])
	if !(var_first_el.clone().is_object()) || !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_first_el }, rt.ArrayItem{ key: none, val: var_callback_or_field }])])) {
		return rt.call_function('wp_list_pluck', [var_list.clone(), var_callback_or_field.clone(), var_index_key.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_index_key)))) {
		mut iter_23 := var_list.iterator()
		for {
			item_23 := iter_23.next() or { break }
			mut var_value_shadow := item_23.val
			mut var_key_shadow := item_23.key
			var_list.array_set(var_key_shadow, rt.call_method(var_value_shadow, var_callback_or_field, []rt.PhpVal{}))
		}
		return var_list.clone()
	}
	var_newlist = rt.new_array()
	mut iter_24 := var_list.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_value_shadow := item_24.val
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_value_shadow }, rt.ArrayItem{ key: none, val: var_index_key }])])) {
			var_newlist.array_set(rt.call_method(var_value_shadow, var_index_key, []rt.PhpVal{}), rt.call_method(var_value_shadow, var_callback_or_field, []rt.PhpVal{}))
		} else if !(rt.get_property(var_value_shadow, '{"nodeType":"Expr_Variable","line":2121,"name":"index_key"}')).is_null() {
			var_newlist.array_set(rt.get_property(var_value_shadow, '{"nodeType":"Expr_Variable","line":2122,"name":"index_key"}'), rt.call_method(var_value_shadow, var_callback_or_field, []rt.PhpVal{}))
		} else {
			var_newlist.array_push(rt.call_method(var_value_shadow, var_callback_or_field, []rt.PhpVal{}))
		}
	}
	return var_newlist.clone()
}

fn wc_get_permalink_structure() rt.PhpVal {
	mut var_saved_permalinks := rt.new_null()
	mut var_permalinks := rt.new_null()
	var_saved_permalinks = rt.cast_array(rt.call_function('get_option', [rt.new_string('woocommerce_permalinks'), rt.new_array()]))
	var_permalinks = rt.call_function('wp_parse_args', [rt.call_function('array_filter', [var_saved_permalinks.clone()]), rt.create_array([rt.ArrayItem{ key: 'product_base', val: rt.call_function('_x', [rt.new_string('product'), rt.new_string('slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'category_base', val: rt.call_function('_x', [rt.new_string('product-category'), rt.new_string('slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'tag_base', val: rt.call_function('_x', [rt.new_string('product-tag'), rt.new_string('slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'attribute_base', val: '' }, rt.ArrayItem{ key: 'use_verbose_page_rules', val: false }])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_saved_permalinks, var_permalinks)))) {
		rt.call_function('update_option', [rt.new_string('woocommerce_permalinks'), var_permalinks.clone()])
	}
	var_permalinks.array_set('product_rewrite_slug', rt.call_function('untrailingslashit', [var_permalinks.array_get(rt.new_string('product_base'))]))
	var_permalinks.array_set('category_rewrite_slug', rt.call_function('untrailingslashit', [var_permalinks.array_get(rt.new_string('category_base'))]))
	var_permalinks.array_set('tag_rewrite_slug', rt.call_function('untrailingslashit', [var_permalinks.array_get(rt.new_string('tag_base'))]))
	var_permalinks.array_set('attribute_rewrite_slug', rt.call_function('untrailingslashit', [var_permalinks.array_get(rt.new_string('attribute_base'))]))
	return var_permalinks.clone()
}

fn wc_switch_to_site_locale() {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('switch_to_locale')])) && !(var_wp_locale_switcher).is_null() {
		rt.call_function('switch_to_locale', [rt.call_function('get_locale', []rt.PhpVal{})])
		rt.call_function('add_filter', [rt.new_string('plugin_locale'), rt.new_string('get_locale')])
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'load_plugin_textdomain', []rt.PhpVal{})
	}
}

fn wc_restore_locale() {
	mut var_wp_locale_switcher := rt.new_null()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('restore_previous_locale')])) && !(var_wp_locale_switcher).is_null() {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
		rt.call_function('remove_filter', [rt.new_string('plugin_locale'), rt.new_string('get_locale')])
		rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'load_plugin_textdomain', []rt.PhpVal{})
	}
}

fn wc_make_phone_clickable(var_phone rt.PhpVal) string {
	mut var_number := ''
	var_number = rt.call_function('preg_replace', [rt.new_string('/[^\\d|\\+]/'), rt.new_string(''), var_phone.clone()]).to_string().trim_space()
	return if var_number.len > 0 && var_number != '0' { '<a href="tel:' + (rt.call_function('esc_attr', [rt.new_string((var_number).str()).clone()])).str() + '">' + (rt.call_function('esc_html', [var_phone.clone()])).str() + '</a>' } else { '' }
}

fn wc_get_post_data_by_key(var_key rt.PhpVal, default string) rt.PhpVal {
	mut var_default := default
	return rt.call_function('wc_clean', [rt.call_function('wp_unslash', [wc_get_var(rt.get_superglobal('_POST').array_get(var_key), rt.new_string(default))])])
}

fn wc_get_var(var_var rt.PhpVal, var_default rt.PhpVal) rt.PhpVal {
	return if !(var_var).is_null() { var_var } else { var_default }
}

fn wc_enable_wc_plugin_headers(var_headers rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Plugin_Updates')]))))) {
		rt.include_file(@DIR + '/admin/plugin-updates/class-wc-plugin-updates.php', '2')
	}
	var_headers << Class_WC_Plugin_Updates.version_required_header()
	var_headers << Class_WC_Plugin_Updates.version_tested_header()
	var_headers << rt.new_string('Woo')
	return var_headers.clone()
}

fn wc_prevent_dangerous_auto_updates(var_should_update rt.PhpVal, var_plugin rt.PhpVal) bool {
	mut var_new_version := rt.new_null()
	mut var_plugin_updates := rt.new_null()
	mut var_version_type := rt.new_null()
	mut var_untested_plugins := rt.new_null()
	if !(!(rt.get_property(var_plugin, 'plugin')).is_null() && !(rt.get_property(var_plugin, 'new_version')).is_null()) {
		return (var_should_update).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce/woocommerce.php'), rt.get_property(var_plugin, 'plugin'))))) {
		return (var_should_update).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Plugin_Updates')]))))) {
		rt.include_file(@DIR + '/admin/plugin-updates/class-wc-plugin-updates.php', '2')
	}
	var_new_version = rt.call_function('wc_clean', [rt.get_property(var_plugin, 'new_version')])
	var_plugin_updates = create_wc_plugin_updates()
	mut iife_temp_18 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_18 := iife_temp_18.get_constant(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE'))
	var_version_type = iife_result_18
	if !(var_version_type.clone().is_string()) {
	var_version_type = rt.new_string('none')
	}
	var_untested_plugins = var_plugin_updates.get_untested_plugins(var_new_version.clone(), var_version_type.clone())
	if !(!rt.is_true(var_untested_plugins)) {
		return false
	}
	return (var_should_update).to_bool()
}

fn wc_delete_expired_transients() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_sql := ''
	mut var_rows := rt.new_null()
	mut var_rows2 := rt.new_null()
	var_sql = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE a, b FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' a, ')), rt.get_property(var_wpdb, 'options')), rt.new_string(' b\n\t\tWHERE a.option_name LIKE %s\n\t\tAND a.option_name NOT LIKE %s\n\t\tAND b.option_name = CONCAT( \'_transient_timeout_\', SUBSTRING( a.option_name, 12 ) )\n\t\tAND b.option_value < %d'))
	var_rows = rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((var_sql).str()).clone(), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_')])).str() + '%'), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_transient_timeout_')])).str() + '%'), rt.call_function('time', []rt.PhpVal{})])])
	var_sql = rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE a, b FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' a, ')), rt.get_property(var_wpdb, 'options')), rt.new_string(' b\n\t\tWHERE a.option_name LIKE %s\n\t\tAND a.option_name NOT LIKE %s\n\t\tAND b.option_name = CONCAT( \'_site_transient_timeout_\', SUBSTRING( a.option_name, 17 ) )\n\t\tAND b.option_value < %d'))
	var_rows2 = rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string((var_sql).str()).clone(), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_')])).str() + '%'), rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_site_transient_timeout_')])).str() + '%'), rt.call_function('time', []rt.PhpVal{})])])
	return rt.call_function('absint', [rt.add(var_rows, var_rows2)])
}

fn wc_get_relative_url(var_url rt.PhpVal) rt.PhpVal {
	return if wc_is_external_resource(var_url.clone()) { var_url } else { rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'http://' }, rt.ArrayItem{ key: none, val: 'https://' }]), rt.new_string('//'), var_url.clone()]) }
}

fn wc_is_external_resource(var_url rt.PhpVal) bool {
	mut var_wp_base := rt.new_null()
	var_wp_base = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'http://' }, rt.ArrayItem{ key: none, val: 'https://' }]), rt.new_string('//'), rt.call_function('get_home_url', [rt.new_null(), rt.new_string('/'), rt.new_string('http')])])
	return rt.is_true(rt.call_function('strstr', [var_url.clone(), rt.new_string('://')])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_url.clone(), var_wp_base.clone()])))))
}

fn wc_is_active_theme(var_theme rt.PhpVal) rt.PhpVal {
	return if var_theme.clone().is_array() { rt.call_function('in_array', [rt.call_function('get_template', []rt.PhpVal{}), var_theme.clone(), rt.new_bool(true)]) } else { rt.identical(rt.call_function('get_template', []rt.PhpVal{}), var_theme) }
}

fn wc_is_wp_default_theme_active() rt.PhpVal {
	return wc_is_active_theme(rt.create_array([rt.ArrayItem{ key: none, val: 'twentytwentythree' }, rt.ArrayItem{ key: none, val: 'twentytwentytwo' }, rt.ArrayItem{ key: none, val: 'twentytwentyone' }, rt.ArrayItem{ key: none, val: 'twentytwenty' }, rt.ArrayItem{ key: none, val: 'twentynineteen' }, rt.ArrayItem{ key: none, val: 'twentyseventeen' }, rt.ArrayItem{ key: none, val: 'twentysixteen' }, rt.ArrayItem{ key: none, val: 'twentyfifteen' }, rt.ArrayItem{ key: none, val: 'twentyfourteen' }, rt.ArrayItem{ key: none, val: 'twentythirteen' }, rt.ArrayItem{ key: none, val: 'twentyeleven' }, rt.ArrayItem{ key: none, val: 'twentytwelve' }, rt.ArrayItem{ key: none, val: 'twentyten' }]))
}

fn wc_cleanup_session_data() {
	mut var_session_class := rt.new_null()
	mut var_session := rt.new_null()
	var_session_class = rt.call_function('apply_filters', [rt.new_string('woocommerce_session_handler'), rt.new_string('WC_Session_Handler')])
	var_session = rt.create_object_dynamically(var_session_class, []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_session }, rt.ArrayItem{ key: none, val: 'cleanup_sessions' }])])) {
		rt.call_method(var_session, 'cleanup_sessions', []rt.PhpVal{})
	}
}

fn wc_decimal_to_fraction(var_decimal rt.PhpVal) rt.PhpVal {
	mut var_tolerance := f64(0.0)
	mut var_numerator := rt.new_null()
	mut var_h2 := i64(0)
	mut var_denominator := rt.new_null()
	mut var_k2 := i64(0)
	mut var_b := rt.new_null()
	mut var_a := rt.new_null()
	mut var_aux := i64(0)
	if rt.is_true(rt.greater(rt.new_int(0), var_decimal)) || !(var_decimal.clone().is_long() || var_decimal.clone().is_double()) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_decimal)) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: 1 }])
	}
	var_tolerance = 0.0001
	var_numerator = rt.new_int(1)
	var_h2 = 0
	var_denominator = rt.new_int(0)
	var_k2 = 1
	var_b = rt.div(rt.new_int(1), var_decimal)
	for {
		var_b = rt.div(rt.new_int(1), var_b)
		var_a = rt.call_function('floor', [var_b.clone()])
		var_aux = (var_numerator).to_i64()
		var_numerator = rt.add(rt.mul(var_a, var_numerator), rt.new_int(var_h2))
		var_h2 = var_aux
		var_aux = (var_denominator).to_i64()
		var_denominator = rt.add(rt.mul(var_a, var_denominator), rt.new_int(var_k2))
		var_k2 = var_aux
		var_b = rt.sub(var_b, var_a)
		if !(rt.is_true(rt.greater(rt.call_function('abs', [rt.sub(var_decimal, rt.div(var_numerator, var_denominator))]), var_decimal * var_tolerance))) {
			break
		}
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_numerator }, rt.ArrayItem{ key: none, val: var_denominator }])
}

fn wc_round_discount(var_value rt.PhpVal, var_precision rt.PhpVal) rt.PhpVal {
	mut iife_temp_19 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_19 := iife_temp_19.round(var_value.clone(), var_precision.clone(), rt.get_constant('WC_DISCOUNT_ROUNDING_MODE'))
	return iife_result_19
	return rt.new_null()
}

fn wc_selected(var_value rt.PhpVal, var_options_arg rt.PhpVal) rt.PhpVal {
	mut var_options := var_options_arg
	if rt.is_true(rt.new_bool(var_options.clone().is_array())) {
		var_options = rt.call_function('array_map', [rt.new_string('strval'), var_options.clone()])
		return rt.call_function('selected', [rt.call_function('in_array', [rt.new_string((var_value).str()), var_options.clone(), rt.new_bool(true)]), rt.new_bool(true), rt.new_bool(false)])
	}
	return rt.call_function('selected', [var_value.clone(), var_options.clone(), rt.new_bool(false)])
}

fn wc_get_server_database_version() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_server_info := rt.new_null()
	if !rt.is_true(rt.get_property(var_wpdb, 'is_mysql')) || !rt.is_true(rt.get_property(var_wpdb, 'use_mysqli')) {
		return rt.create_array([rt.ArrayItem{ key: 'string', val: '' }, rt.ArrayItem{ key: 'number', val: '' }])
	}
	var_server_info = rt.call_method(var_wpdb, 'get_var', [rt.new_string('SELECT VERSION()')])
	return rt.create_array([rt.ArrayItem{ key: 'string', val: var_server_info }, rt.ArrayItem{ key: 'number', val: rt.call_function('preg_replace', [rt.new_string('/([^\\d.]+).*/'), rt.new_string(''), var_server_info.clone()]) }])
}

fn wc_load_cart() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('before_woocommerce_init')]))))) || rt.is_true(rt.call_function('doing_action', [rt.new_string('before_woocommerce_init')])) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s should not be called before the %2$s action.'), rt.new_string('woocommerce')]), rt.new_string('wc_load_cart'), rt.new_string('woocommerce_init')]), rt.new_string('3.7')])
		return
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-cart-functions.php', '2')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-notice-functions.php', '2')
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'initialize_session', []rt.PhpVal{})
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'initialize_cart', []rt.PhpVal{})
}

fn wc_is_running_from_async_action_scheduler() bool {
	return rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.new_string('as_async_request_queue_runner'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))))
}

fn wc_cache_get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut var_group := group
	mut var_force := force
	mut var_values := rt.new_null()
	mut var_key := rt.new_null()
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get_multiple')])) {
		return rt.call_function('wp_cache_get_multiple', [var_keys.clone(), rt.new_string(group), rt.new_bool(force)])
	}
	var_values = rt.new_array()
	mut iter_25 := var_keys.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_key_shadow := item_25.val
		var_values.array_set(var_key_shadow, rt.call_function('wp_cache_get', [var_key_shadow.clone(), rt.new_string(group), rt.new_bool(force)]))
	}
	return var_values.clone()
}

fn _wc_delete_transients(var_transients rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_transient := rt.new_null()
	mut var_transient_names := []rt.PhpVal{}
	mut var_chunks := rt.new_null()
	mut var_success := false
	mut var_chunk := rt.new_null()
	mut var_result := rt.new_null()
	mut var_options_to_clear := rt.new_null()
	mut var_option_name := rt.new_null()
	mut var_alloptions := rt.new_null()
	mut var_updated_alloptions := false
	mut var_e := rt.new_null()
	if !rt.is_true(var_transients) || !(var_transients.clone().is_array()) {
		return false
	}
	if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) {
		mut iter_26 := var_transients.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_transient_shadow := item_26.val
			rt.call_function('delete_transient', [var_transient_shadow.clone()])
		}
		return true
	} else {
		var_transient_names = rt.new_array()
		mut iter_27 := var_transients.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_transient_shadow := item_27.val
			var_transient_names << '_transient_' + (var_transient_shadow).str()
			var_transient_names << '_transient_timeout_' + (var_transient_shadow).str()
		}
		if var_transients.clone().array_count() > 199 {
			var_chunks = rt.call_function('array_chunk', [var_transients.clone(), rt.new_int(100)])
			var_success = true
			mut iter_28 := var_chunks.iterator()
			for {
				item_28 := iter_28.next() or { break }
				mut var_chunk_shadow := item_28.val
				var_result = rt.new_bool(_wc_delete_transients(var_chunk_shadow.clone()))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
				var_success = false
				}
				rt.call_function('gc_collect_cycles', []rt.PhpVal{})
			}
			return var_success
		}
		var_options_to_clear = rt.new_array()
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
			var_options_to_clear = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('SELECT option_name FROM ' + (rt.get_property(var_wpdb, 'options')).str() + ' WHERE option_name IN ( ' + (rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_transient_names.len), rt.new_string('%s')])])).str() + ' )'), rt.create_array_from_list(var_transient_names)])])
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if !rt.is_true(var_options_to_clear) {
			return true
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.new_string('DELETE FROM ' + (rt.get_property(var_wpdb, 'options')).str() + ' WHERE option_name IN ( ' + (rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_options_to_clear.clone().array_count()), rt.new_string('%s')])])).str() + ' )'), var_options_to_clear.clone()])])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
			if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_delete_multiple')])) {
				rt.call_function('wp_cache_delete_multiple', [var_options_to_clear.clone(), rt.new_string('options')])
				if rt.has_exception() { unsafe { goto catch_label_4 } }
			} else {
				mut iter_29 := var_options_to_clear.iterator()
				for {
					item_29 := iter_29.next() or { break }
					mut var_option_name_shadow := item_29.val
					rt.call_function('wp_cache_delete', [var_option_name_shadow.clone(), rt.new_string('options')])
					if rt.has_exception() { unsafe { goto catch_label_4 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_4 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			var_alloptions = rt.call_function('wp_load_alloptions', [rt.new_bool(true)])
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			var_updated_alloptions = false
			if rt.has_exception() { unsafe { goto catch_label_4 } }
			if rt.is_true(rt.new_bool(var_alloptions.clone().is_array())) {
				mut iter_30 := var_options_to_clear.iterator()
				for {
					item_30 := iter_30.next() or { break }
					mut var_option_name_shadow := item_30.val
					if var_alloptions.array_isset(var_option_name_shadow) {
						var_alloptions.array_unset(var_option_name_shadow)
						if rt.has_exception() { unsafe { goto catch_label_4 } }
						var_updated_alloptions = true
						if rt.has_exception() { unsafe { goto catch_label_4 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_4 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_4 } }
				if var_updated_alloptions {
					rt.call_function('wp_cache_set', [rt.new_string('alloptions'), var_alloptions.clone(), rt.new_string('options')])
					if rt.has_exception() { unsafe { goto catch_label_4 } }
				}
				if rt.has_exception() { unsafe { goto catch_label_4 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_4 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		return true
		unsafe { goto end_label_4 }

catch_label_4:
		mut var_e_4 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_4, 'Exception') {
			var_e = var_e_4.clone()
			rt.call_method(wc_get_logger(), 'error', [rt.call_function('sprintf', [rt.new_string('Exception when deleting transients: %s'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: '_wc_delete_transients' }])])
			return false
			unsafe { goto end_label_4 }
		}
		else {
			rt.throw_exception(var_e_4)
			unsafe { goto end_label_4 }
		}

end_label_4:
	}
	return false
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_WC_Geolocation {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Zones {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_Collator {
	rt.PhpObjectBase
}

struct Class_WC_Logger {
	rt.PhpObjectBase
}

struct Class_WC_Plugin_Updates {
	rt.PhpObjectBase
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation(_args ...rt.PhpVal) &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_zones(_args ...rt.PhpVal) &Class_WC_Shipping_Zones {
	mut obj := &Class_WC_Shipping_Zones{
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

fn create_collator(_args ...rt.PhpVal) &Class_Collator {
	mut obj := &Class_Collator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_logger(_args ...rt.PhpVal) &Class_WC_Logger {
	mut obj := &Class_WC_Logger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_plugin_updates(_args ...rt.PhpVal) &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Geolocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geolocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geolocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shipping_Zones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Zones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Zones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Collator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Collator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Collator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Plugin_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Plugin_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Plugin_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('wc_maybe_define_constant', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wc_maybe_define_constant(arg_0, arg_1)
	})
	rt.register_func('wc_create_order', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_create_order(arg_0)
	})
	rt.register_func('wc_update_order', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_update_order(arg_0)
	})
	rt.register_func('wc_tokenize_path', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_tokenize_path(arg_0, arg_1)
	})
	rt.register_func('wc_untokenize_path', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_untokenize_path(arg_0, arg_1)
	})
	rt.register_func('wc_get_path_define_tokens', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_path_define_tokens()
	})
	rt.register_func('wc_get_template_part', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wc_get_template_part(arg_0, arg_1)
	})
	rt.register_func('wc_get_template', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return wc_get_template(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wc_get_template_html', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		return wc_get_template_html(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('wc_locate_template', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return wc_locate_template(arg_0, arg_1, arg_2)
	})
	rt.register_func('wc_set_template_cache', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_set_template_cache(arg_0, arg_1)
	})
	rt.register_func('wc_clear_template_cache', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_clear_template_cache()
	})
	rt.register_func('wc_clear_system_status_theme_info_cache', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_clear_system_status_theme_info_cache()
	})
	rt.register_func('get_woocommerce_currency', fn(args []rt.PhpVal) rt.PhpVal {
		return get_woocommerce_currency()
	})
	rt.register_func('get_woocommerce_currencies', fn(args []rt.PhpVal) rt.PhpVal {
		return get_woocommerce_currencies()
	})
	rt.register_func('get_woocommerce_currency_symbols', fn(args []rt.PhpVal) rt.PhpVal {
		return get_woocommerce_currency_symbols()
	})
	rt.register_func('get_woocommerce_currency_symbol', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		return get_woocommerce_currency_symbol(arg_0)
	})
	rt.register_func('wc_mail', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		return wc_mail(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('wc_get_theme_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_get_theme_support(arg_0, arg_1)
	})
	rt.register_func('wc_get_image_size', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_image_size(arg_0)
	})
	rt.register_func('wc_enqueue_js', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_enqueue_js(arg_0)
	})
	rt.register_func('wc_print_js', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_print_js()
	})
	rt.register_func('wc_setcookie', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
		return wc_setcookie(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('wc_get_page_children', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_page_children(arg_0)
	})
	rt.register_func('flush_rewrite_rules_on_shop_page_save', fn(args []rt.PhpVal) rt.PhpVal {
		return flush_rewrite_rules_on_shop_page_save()
	})
	rt.register_func('wc_fix_rewrite_rules', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_fix_rewrite_rules(arg_0)
	})
	rt.register_func('wc_fix_product_attachment_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_fix_product_attachment_link(arg_0, arg_1)
	})
	rt.register_func('wc_ms_protect_download_rewite_rules', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wc_ms_protect_download_rewite_rules(arg_0))
	})
	rt.register_func('wc_format_country_state_string', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_format_country_state_string(arg_0)
	})
	rt.register_func('wc_get_base_location', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_base_location()
	})
	rt.register_func('wc_get_customer_geolocation', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_customer_geolocation(arg_0)
	})
	rt.register_func('wc_get_customer_default_location', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_customer_default_location()
	})
	rt.register_func('wc_get_user_agent', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_user_agent()
	})
	rt.register_func('wc_rand_hash', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(wc_rand_hash(arg_0, arg_1))
	})
	rt.register_func('wc_api_hash', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_api_hash(arg_0)
	})
	rt.register_func('wc_array_cartesian', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_array_cartesian(arg_0)
	})
	rt.register_func('wc_transaction_query', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wc_transaction_query(arg_0, arg_1)
	})
	rt.register_func('wc_get_cart_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_cart_url()
	})
	rt.register_func('wc_get_checkout_url', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_checkout_url()
	})
	rt.register_func('woocommerce_register_shipping_method', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return woocommerce_register_shipping_method(arg_0)
	})
	rt.register_func('wc_get_shipping_zone', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_shipping_zone(arg_0)
	})
	rt.register_func('wc_get_credit_card_type_label', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_credit_card_type_label(arg_0)
	})
	rt.register_func('wc_back_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_back_link(arg_0, arg_1)
	})
	rt.register_func('wc_back_header', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wc_back_header(arg_0, arg_1, arg_2)
	})
	rt.register_func('wc_help_tip', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wc_help_tip(arg_0, arg_1)
	})
	rt.register_func('wc_get_wildcard_postcodes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wc_get_wildcard_postcodes(arg_0, arg_1)
	})
	rt.register_func('wc_postcode_location_matcher', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
		return wc_postcode_location_matcher(arg_0, arg_1, arg_2, arg_3, arg_4)
	})
	rt.register_func('wc_get_shipping_method_count', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return wc_get_shipping_method_count(arg_0, arg_1)
	})
	rt.register_func('wc_set_time_limit', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		return wc_set_time_limit(arg_0)
	})
	rt.register_func('wc_nocache_headers', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_nocache_headers()
	})
	rt.register_func('wc_product_attribute_uasort_comparison', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_product_attribute_uasort_comparison(arg_0, arg_1)
	})
	rt.register_func('wc_shipping_zone_method_order_uasort_comparison', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_shipping_zone_method_order_uasort_comparison(arg_0, arg_1)
	})
	rt.register_func('wc_checkout_fields_uasort_comparison', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(wc_checkout_fields_uasort_comparison(arg_0, arg_1))
	})
	rt.register_func('wc_uasort_comparison', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_int(wc_uasort_comparison(arg_0, arg_1))
	})
	rt.register_func('wc_ascii_uasort_comparison', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_ascii_uasort_comparison(arg_0, arg_1)
	})
	rt.register_func('wc_asort_by_locale', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wc_asort_by_locale(arg_0, arg_1)
	})
	rt.register_func('wc_get_tax_rounding_mode', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(wc_get_tax_rounding_mode())
	})
	rt.register_func('wc_get_rounding_precision', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_rounding_precision()
	})
	rt.register_func('wc_add_number_precision', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_float(wc_add_number_precision(arg_0, arg_1))
	})
	rt.register_func('wc_remove_number_precision', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_float(wc_remove_number_precision(arg_0))
	})
	rt.register_func('wc_add_number_precision_deep', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_float(wc_add_number_precision_deep(arg_0, arg_1))
	})
	rt.register_func('wc_remove_number_precision_deep', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_float(wc_remove_number_precision_deep(arg_0))
	})
	rt.register_func('wc_get_logger', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_logger()
	})
	rt.register_func('wc_cleanup_logs', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_cleanup_logs()
	})
	rt.register_func('wc_print_r', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(wc_print_r(arg_0, arg_1))
	})
	rt.register_func('wc_list_pluck', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return wc_list_pluck(arg_0, arg_1, arg_2)
	})
	rt.register_func('wc_get_permalink_structure', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_permalink_structure()
	})
	rt.register_func('wc_switch_to_site_locale', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_switch_to_site_locale()
	})
	rt.register_func('wc_restore_locale', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_restore_locale()
	})
	rt.register_func('wc_make_phone_clickable', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(wc_make_phone_clickable(arg_0))
	})
	rt.register_func('wc_get_post_data_by_key', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wc_get_post_data_by_key(arg_0, arg_1)
	})
	rt.register_func('wc_get_var', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_get_var(arg_0, arg_1)
	})
	rt.register_func('wc_enable_wc_plugin_headers', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_enable_wc_plugin_headers(arg_0)
	})
	rt.register_func('wc_prevent_dangerous_auto_updates', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(wc_prevent_dangerous_auto_updates(arg_0, arg_1))
	})
	rt.register_func('wc_delete_expired_transients', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_delete_expired_transients()
	})
	rt.register_func('wc_get_relative_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_get_relative_url(arg_0)
	})
	rt.register_func('wc_is_external_resource', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(wc_is_external_resource(arg_0))
	})
	rt.register_func('wc_is_active_theme', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_is_active_theme(arg_0)
	})
	rt.register_func('wc_is_wp_default_theme_active', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_is_wp_default_theme_active()
	})
	rt.register_func('wc_cleanup_session_data', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_cleanup_session_data()
	})
	rt.register_func('wc_decimal_to_fraction', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wc_decimal_to_fraction(arg_0)
	})
	rt.register_func('wc_round_discount', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_round_discount(arg_0, arg_1)
	})
	rt.register_func('wc_selected', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wc_selected(arg_0, arg_1)
	})
	rt.register_func('wc_get_server_database_version', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_get_server_database_version()
	})
	rt.register_func('wc_load_cart', fn(args []rt.PhpVal) rt.PhpVal {
		return wc_load_cart()
	})
	rt.register_func('wc_is_running_from_async_action_scheduler', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_bool(wc_is_running_from_async_action_scheduler())
	})
	rt.register_func('wc_cache_get_multiple', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return wc_cache_get_multiple(arg_0, arg_1, arg_2)
	})
	rt.register_func('_wc_delete_transients', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_wc_delete_transients(arg_0))
	})
	rt.register_class_factory('WC_Order', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_order()
		return rt.new_object('WC_Order', []string{}, obj)
	})
	rt.register_class_factory('WC_Geolocation', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_geolocation()
		return rt.new_object('WC_Geolocation', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('Automattic_Jetpack_Constants', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_jetpack_constants()
		return rt.new_object('Automattic_Jetpack_Constants', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_NumberUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_numberutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_NumberUtil', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_blocks_utils_cartcheckoututils()
		return rt.new_object('Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils', []string{}, obj)
	})
	rt.register_class_factory('WC_Shipping_Zones', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_shipping_zones()
		return rt.new_object('WC_Shipping_Zones', []string{}, obj)
	})
	rt.register_class_factory('WC_Cache_Helper', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_cache_helper()
		return rt.new_object('WC_Cache_Helper', []string{}, obj)
	})
	rt.register_class_factory('Collator', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_collator()
		return rt.new_object('Collator', []string{}, obj)
	})
	rt.register_class_factory('WC_Logger', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_logger()
		return rt.new_object('WC_Logger', []string{}, obj)
	})
	rt.register_class_factory('WC_Plugin_Updates', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_plugin_updates()
		return rt.new_object('WC_Plugin_Updates', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-conditional-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-coupon-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-user-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-deprecated-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-formatting-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-order-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-order-item-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-page-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-product-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-stock-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-account-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-term-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-attribute-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-rest-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-widget-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-webhook-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-order-step-logger-functions.php', '3')
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/wc-interactivity-api-functions.php', '3')
	rt.call_function('add_filter', [rt.new_string('woocommerce_coupon_code'), rt.new_string('wc_sanitize_coupon_code')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_coupon_code'), rt.new_string('wc_strtolower')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_stock_amount'), rt.new_string('intval')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_shipping_rate_label'), rt.new_string('sanitize_text_field')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_attribute_label'), rt.new_string('wp_kses_post'), rt.new_int(100)])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('do_blocks')])) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('do_blocks'), rt.new_int(9)])
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('wptexturize')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('convert_smilies')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('convert_chars')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('wpautop')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('shortcode_unautop')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('prepend_attachment')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('do_shortcode'), rt.new_int(11)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('wc_format_product_short_description'), rt.new_int(9999999)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.new_string('wc_do_oembeds')])
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.create_array([rt.ArrayItem{ key: none, val: var_GLOBALS.array_get(rt.new_string('wp_embed')) }, rt.ArrayItem{ key: none, val: 'run_shortcode' }]), rt.new_int(8)])
	rt.call_function('add_action', [rt.new_string('admin_footer'), rt.new_string('flush_rewrite_rules_on_shop_page_save')])
	rt.call_function('add_filter', [rt.new_string('rewrite_rules_array'), rt.new_string('wc_fix_rewrite_rules')])
	rt.call_function('add_filter', [rt.new_string('attachment_link'), rt.new_string('wc_fix_product_attachment_link'), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('mod_rewrite_rules'), rt.new_string('wc_ms_protect_download_rewite_rules')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_shipping_zone')]))))) {
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_cleanup_logs'), rt.new_string('wc_cleanup_logs')])
	rt.call_function('add_filter', [rt.new_string('extra_theme_headers'), rt.new_string('wc_enable_wc_plugin_headers')])
	rt.call_function('add_filter', [rt.new_string('extra_plugin_headers'), rt.new_string('wc_enable_wc_plugin_headers')])
	rt.call_function('add_filter', [rt.new_string('auto_update_plugin'), rt.new_string('wc_prevent_dangerous_auto_updates'), rt.new_int(99), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'), rt.new_string('wc_delete_expired_transients')])
	rt.call_function('add_action', [rt.new_string('woocommerce_cleanup_sessions'), rt.new_string('wc_cleanup_session_data')])
}
