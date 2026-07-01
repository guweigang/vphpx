import rt

fn wc_maybe_define_constant(name string, value bool) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string(name)]))))) {
		rt.call_function('define', [rt.new_string(name), rt.new_bool(value)])
	}
}

fn wc_create_order(var_args rt.PhpVal) rt.PhpVal {
	mut var_default_args := { 'status': rt.new_null(), 'customer_id': rt.new_null(), 'customer_note': rt.new_null(), 'parent': rt.new_null(), 'created_via': rt.new_null(), 'cart_hash': rt.new_null(), 'order_id': rt.new_int(0) }
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_default_args.dup()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_order := create_wc_order(var_args.array_get('order_id'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('parent').is_null()))))) {
		var_order.set_parent_id(rt.call_function('absint', [var_args.array_get('parent')]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('status').is_null()))))) {
		var_order.set_status(var_args.array_get('status'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('customer_note').is_null()))))) {
		var_order.set_customer_note(var_args.array_get('customer_note'))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('customer_id').is_null()))))) {
		var_order.set_customer_id(if rt.is_true(rt.new_bool(var_args.array_get('customer_id').is_long() || var_args.array_get('customer_id').is_double())) { rt.call_function('absint', [var_args.array_get('customer_id')]) } else { rt.new_int(0) })
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('created_via').is_null()))))) {
		var_order.set_created_via(rt.call_function('sanitize_text_field', [var_args.array_get('created_via')]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args.array_get('cart_hash').is_null()))))) {
		var_order.set_cart_hash(rt.call_function('sanitize_text_field', [var_args.array_get('cart_hash')]))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('order_id'))))) {
		var_order.set_currency(get_woocommerce_currency())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_order.set_prices_include_tax(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_prices_include_tax')])))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		var_order.set_customer_ip_address(fn () rt.PhpVal { mut temp := Class_WC_Geolocation{}; return temp.get_ip_address() }())
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
		mut var_e := var_e_1.dup()
		return mut rt.cast_object_ptr[Class_WC_Order](create_wp_error(rt.new_string('error'), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})))
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
	if !rt.is_true(var_args.array_get('order_id')) {
		return mut rt.cast_object_ptr[Class_WC_Order](create_wp_error(rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')])))
	}
	return mut wc_create_order(var_args.dup())
}

fn wc_tokenize_path(var_path rt.PhpVal, var_path_tokens rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	var_a = rt.new_int(rt.new_int(var_a.dup().to_string().len))
	var_b = rt.new_int(rt.new_int(var_b.dup().to_string().len))
	if rt.is_true(rt.greater(var_a, var_b)) {
		return // unsupported expression: Expr_UnaryMinus
	}
	if rt.is_true(rt.greater(var_b, var_a)) {
		return rt.new_int(1)
	}
	return rt.new_int(0)
	}
	rt.call_function('uasort', [var_path_tokens.dup(), rt.new_closure(closure_1_fn)])
	{
		mut iter_1 := var_path_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token_path := item_1.val
			mut var_token := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				continue
			}
			var_path = rt.call_function('str_replace', [var_token_path.dup(), '{{' + (var_token).str() + '}}', var_path.dup()])
		}
	}
	return var_path.dup()
}

fn wc_untokenize_path(var_path rt.PhpVal, var_path_tokens rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_path_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token_path := item_1.val
			mut var_token := item_1.key
			var_path = rt.call_function('str_replace', ['{{' + (var_token).str() + '}}', var_token_path.dup(), var_path.dup()])
		}
	}
	return var_path.dup()
}

fn wc_get_path_define_tokens() rt.PhpVal {
	mut var_defines := ['ABSPATH', 'WP_CONTENT_DIR', 'WP_PLUGIN_DIR', 'WPMU_PLUGIN_DIR', 'PLUGINDIR', 'WP_THEME_DIR']
	mut var_path_tokens := rt.new_array()
	for var_define in var_defines {
		if rt.is_true(rt.call_function('defined', [rt.new_string(define)])) {
			var_path_tokens.array_set(define, rt.call_function('constant', [rt.new_string(define)]))
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_get_path_define_tokens'), var_path_tokens.dup()])
}

fn wc_get_template_part(var_slug rt.PhpVal, name string) {
	mut var_cache_key := rt.call_function('sanitize_key', [rt.call_function('implode', [rt.new_string('-'), rt.create_array([rt.ArrayItem{ key: none, val: 'template-part' }, rt.ArrayItem{ key: none, val: var_slug }, rt.ArrayItem{ key: none, val: name }, rt.ArrayItem{ key: none, val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION')) }])])])
	mut var_template := // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		if var_name.len > 0 && var_name != '0' {
			var_template = if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) { rt.new_string('') } else { rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: "${var_slug.to_string()}-${var_name}.php" }, rt.ArrayItem{ key: none, val: (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + "${var_slug.to_string()}-${var_name}.php" }])]) }
			if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
				mut var_fallback := rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + "/templates/${var_slug.to_string()}-${var_name}.php")
				var_template = if rt.is_true(rt.call_function('file_exists', [var_fallback.dup()])) { var_fallback } else { rt.new_string('') }
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
			var_template = if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) { rt.new_string('') } else { rt.call_function('locate_template', [rt.create_array([rt.ArrayItem{ key: none, val: "${var_slug.to_string()}.php" }, rt.ArrayItem{ key: none, val: (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + "${var_slug.to_string()}.php" }])]) }
		}
		mut var_cache_path := wc_tokenize_path(var_template.dup(), wc_get_path_define_tokens())
		wc_set_template_cache(var_cache_key.dup(), var_cache_path.dup())
	} else {
		var_template = wc_untokenize_path(var_template.dup(), wc_get_path_define_tokens())
	}
	var_template = rt.call_function('apply_filters', [rt.new_string('wc_get_template_part'), var_template.dup(), var_slug.dup(), rt.new_string(name)])
	if rt.is_true(var_template) {
		rt.call_function('load_template', [var_template.dup(), rt.new_bool(false)])
	}
}

fn wc_get_template(var_template_name rt.PhpVal, var_args rt.PhpVal, template_path string, default_path string) {
	mut var_cache_key := rt.call_function('sanitize_key', [])
	mut var_template := 
	if rt.is_true() {
	} else {
	}
	
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

fn create_wc_order() &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_geolocation() &Class_WC_Geolocation {
	mut obj := &Class_WC_Geolocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_wc_core_functions_php() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
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
	rt.call_function('add_filter', [rt.new_string('woocommerce_short_description'), rt.create_array([rt.ArrayItem{ key: none, val: var_GLOBALS.array_get('wp_embed') }, rt.ArrayItem{ key: none, val: 'run_shortcode' }]), rt.new_int(8)])
}
