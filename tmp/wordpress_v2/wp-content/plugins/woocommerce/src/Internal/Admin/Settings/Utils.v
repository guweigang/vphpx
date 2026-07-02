import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_apply_mappings(mut var_base_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, mut var_new_mappings Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	rt.call_function('asort', [var_base_map])
	mut var_updated_map := var_base_map
	mut iter_1 := var_new_mappings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order := item_1.val
		mut var_id := item_1.key
		if !(var_base_map.array_isset(var_id)) {
			var_updated_map = Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_add_at_order(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_updated_map), (var_id).str(), (var_order).to_i64())
			continue
		}
	var_updated_map = Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_move_at_order(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_updated_map), (var_id).str(), (var_order).to_i64())
	}
	return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_normalize(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](var_updated_map))
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_move_at_order(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, id string, order i64) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	if !(var_order_map_mutated.array_isset(rt.new_string(id))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	if rt.is_true(rt.identical(var_order_map_mutated.array_get(rt.new_string(id)), rt.new_int(order))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_int(order), var_order_map_mutated, rt.new_bool(true)]))))) {
		var_order_map_mutated.array_set(id, order)
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	mut var_existing_order := var_order_map_mutated.array_get(rt.new_string(id))
	if rt.is_true(rt.greater(rt.new_int(order), var_existing_order)) {
		mut iter_2 := var_order_map_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.less_equal(var_value, rt.new_int(order))) && rt.is_true(rt.greater_equal(var_value, var_existing_order)) {
				rt.pre_dec(var_order_map_mutated.array_get(var_key))
			}
		}
	} else {
		mut iter_3 := var_order_map_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value := item_3.val
			mut var_key := item_3.key
			if rt.is_true(rt.greater_equal(var_value, rt.new_int(order))) && rt.is_true(rt.less_equal(var_value, var_existing_order)) {
				rt.pre_inc(var_order_map_mutated.array_get(var_key))
			}
		}
	}
	var_order_map_mutated.array_set(id, order)
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_place_at_order(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, id string, order i64) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	if var_order_map_mutated.array_isset(rt.new_string(id)) && rt.is_true(rt.identical(var_order_map_mutated.array_get(rt.new_string(id)), rt.new_int(order))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_int(order), var_order_map_mutated, rt.new_bool(true)]))))) {
		var_order_map_mutated.array_set(id, order)
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	mut iter_4 := var_order_map_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.greater_equal(var_value, rt.new_int(order))) {
			rt.pre_inc(var_order_map_mutated.array_get(var_key))
		}
	}
	var_order_map_mutated.array_set(id, order)
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_add_at_order(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, id string, order i64) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	if var_order_map_mutated.array_isset(rt.new_string(id)) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_order_map_mutated)
	}
	return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_place_at_order(mut var_order_map_mutated, id, order)
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_normalize(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_key := rt.new_null()
	mut var_order_map_mutated := var_order_map
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_key := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_key.clone().is_string())
		}
	var_order_map_mutated = rt.call_function('array_filter', [var_order_map_mutated, rt.new_closure(closure_1_fn), rt.get_constant('ARRAY_FILTER_USE_KEY')])
	rt.call_function('asort', [var_order_map_mutated])
	return rt.call_function('array_flip', [rt.func_array_keys(var_order_map_mutated)])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_change_min_order(mut var_order_map Class_Automattic_WooCommerce_Internal_Admin_Settings_array, new_min_order i64) rt.PhpVal {
	mut var_order_map_mutated := var_order_map
	if !rt.is_true(var_order_map_mutated) {
		return rt.new_array()
	}
	mut var_updated_map := rt.new_array()
	mut var_bump := rt.sub(rt.new_int(new_min_order), rt.call_function('min', [var_order_map_mutated]))
	mut iter_5 := var_order_map_mutated.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_order := item_5.val
		mut var_id := item_5.key
		var_updated_map.array_set(var_id, rt.add(var_order, var_bump))
	}
	rt.call_function('asort', [var_updated_map.clone()])
	return var_updated_map.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_testing_plugin_slug_suffixes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: '-dev' }, rt.ArrayItem{ key: none, val: '-rc' }, rt.ArrayItem{ key: none, val: '-test' }, rt.ArrayItem{ key: none, val: '-beta' }, rt.ArrayItem{ key: none, val: '-alpha' }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.generate_testing_plugin_slugs(slug string, include_original bool) rt.PhpVal {
	mut slug_mutated := slug
	mut var_slugs := rt.new_array()
	if var_include_original {
		var_slugs.array_push(slug_mutated)
	}
	mut iter_6 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_testing_plugin_slug_suffixes().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_suffix := item_6.val
		var_slugs.array_push(slug_mutated + (var_suffix).str())
	}
	return var_slugs.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.normalize_plugin_slug(slug string) string {
	mut var_matches := rt.new_null()
	mut slug_mutated := slug
	if slug_mutated == '' || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[\\w-]+$/'), rt.new_string(slug_mutated).clone(), var_matches.clone()]))))) {
		return slug_mutated
	}
	slug_mutated = slug_mutated.to_lower()
	mut iter_7 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_testing_plugin_slug_suffixes().iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_suffix := item_7.val
	slug_mutated = (if rt.is_true(rt.call_function('str_ends_with', [rt.new_string(slug_mutated).clone(), var_suffix.clone()])) { rt.call_function('substr', [rt.new_string(slug_mutated).clone(), rt.new_int(0), rt.new_int(-var_suffix.clone().to_string().len)]) } else { rt.new_string(slug_mutated) }).str()
	}
	return slug_mutated
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.trim_php_file_extension(path string) string {
	mut path_mutated := path
	if !(path_mutated == '') && rt.is_true(rt.call_function('str_ends_with', [rt.new_string(path_mutated).clone(), rt.new_string('.php')])) {
	path_mutated = (rt.call_function('substr', [rt.new_string(path_mutated).clone(), rt.new_int(0), rt.new_int(-4)])).str()
	}
	return path_mutated
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.truncate_with_words(text string, target_length i64, append string) string {
	mut text_mutated := text
	if rt.is_true(rt.call_function('str_starts_with', [rt.call_function('wp_get_word_count_type', []rt.PhpVal{}), rt.new_string('characters')])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^utf\\-?8$/i'), rt.call_function('get_option', [rt.new_string('blog_charset')])])) {
		text_mutated = rt.call_function('preg_replace', [rt.new_string('/[\n\r\t ]+/'), rt.new_string(' '), rt.new_string(text_mutated).clone()]).to_string().trim_space()
		rt.call_function('preg_match_all', [rt.new_string('/./u'), rt.new_string(text_mutated).clone(), var_words_array.clone()])
		if var_words_array.array_get(rt.new_int(0)).array_count() <= target_length {
			return text_mutated
		}
		mut var_words_array := rt.call_function('array_slice', [var_words_array.array_get(rt.new_int(0)), rt.new_int(0), rt.new_int(target_length)])
		mut var_truncated := rt.call_function('implode', [rt.new_string(''), var_words_array.clone()])
		if var_append.len > 0 && var_append != '0' {
			var_truncated = rt.concat(var_truncated, rt.new_string(append))
		}
		return (var_truncated).str()
	}
	if text_mutated.len <= target_length {
		return text_mutated
	}
	var_words_array = rt.call_function('preg_split', [rt.new_string('/[\n\r\t ]+/'), rt.new_string(text_mutated).clone(), rt.new_int(-1), rt.get_constant('PREG_SPLIT_NO_EMPTY')])
	mut var_sep := rt.new_string(' ')
	var_truncated = rt.new_string('')
	mut var_remaining_length := rt.new_int(target_length)
	for rt.is_true(rt.greater(var_remaining_length, rt.new_int(0))) && !(!rt.is_true(var_words_array)) {
		mut var_word := rt.call_function('array_shift', [var_words_array.clone()])
		var_truncated = rt.concat(var_truncated, rt.new_string((var_word).str() + (var_sep).str()))
		var_remaining_length = rt.sub(var_remaining_length, rt.new_int((var_word).str() + (var_sep).str().len))
	}
	var_truncated = rt.new_string(var_truncated.clone().to_string().trim_right(' \t\n\r'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.new_string(append))))) {
		var_truncated = rt.concat(var_truncated, rt.new_string(append))
	}
	return (var_truncated).str()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.wc_payments_settings_url(mut var_path Class_Automattic_WooCommerce_Internal_Admin_Settings_?string, mut var_query Class_Automattic_WooCommerce_Internal_Admin_Settings_array) string {
	mut var_path_mutated := var_path
	var_path_mutated = rt.new_string((if rt.is_true(var_path_mutated) { '&path=' + (var_path_mutated).str() } else { '' }).str())
	mut var_query_string := rt.new_string('')
	if !(!rt.is_true(var_query)) {
	var_query_string = rt.new_string('&' + (rt.call_function('http_build_query', [var_query])).str())
	}
	return (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=checkout' + (var_path_mutated).str() + (var_query_string).str())])).str()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.rest_endpoint_get_request(endpoint string, mut var_params Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_request := create_wp_rest_request(rt.new_string('GET'), rt.new_string(endpoint))
	if rt.is_true(var_params) {
		var_request.set_query_params(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_params))
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_response_data := rt.call_function('json_decode', [rt.call_function('wp_json_encode', [rt.call_method(var_server, 'response_to_data', [var_response.clone(), rt.new_bool(false)])]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_method(var_response, 'get_status', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_WP_Error', []string{}, create_automattic_woocommerce_internal_admin_settings_wp_error(rt.new_string('woocommerce_settings_payments_rest_error'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('REST request GET %1$s failed with: (%2$s) %3$s'), rt.new_string('woocommerce')]), rt.new_string(endpoint), if !(var_response_data.array_get(rt.new_string('code'))).is_null() { var_response_data.array_get(rt.new_string('code')) } else { rt.new_string('unknown_error') }, if !(var_response_data.array_get(rt.new_string('message'))).is_null() { var_response_data.array_get(rt.new_string('message')) } else { rt.call_function('esc_html__', [rt.new_string('Unknown error'), rt.new_string('woocommerce')]) }]), var_response_data.clone()))
	}
	return var_response_data.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.rest_endpoint_post_request(endpoint string, mut var_params Class_Automattic_WooCommerce_Internal_Admin_Settings_array) rt.PhpVal {
	mut var_request := create_wp_rest_request(rt.new_string('POST'), rt.new_string(endpoint))
	if rt.is_true(var_params) {
		var_request.set_body_params(rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_array', []string{}, var_params))
	}
	mut var_response := rt.call_function('rest_do_request', [var_request])
	mut var_server := rt.call_function('rest_get_server', []rt.PhpVal{})
	mut var_response_data := rt.call_function('json_decode', [rt.call_function('wp_json_encode', [rt.call_method(var_server, 'response_to_data', [var_response.clone(), rt.new_bool(false)])]), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_method(var_response, 'get_status', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Settings_WP_Error', []string{}, create_automattic_woocommerce_internal_admin_settings_wp_error(rt.new_string('woocommerce_settings_payments_rest_error'), rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('REST request POST %1$s failed with: (%2$s) %3$s'), rt.new_string('woocommerce')]), rt.new_string(endpoint), if !(var_response_data.array_get(rt.new_string('code'))).is_null() { var_response_data.array_get(rt.new_string('code')) } else { rt.new_string('unknown_error') }, if !(var_response_data.array_get(rt.new_string('message'))).is_null() { var_response_data.array_get(rt.new_string('message')) } else { rt.call_function('esc_html__', [rt.new_string('Unknown error'), rt.new_string('woocommerce')]) }]), var_response_data.clone()))
	}
	return var_response_data.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_wpcom_connection_authorization(return_url string) rt.PhpVal {
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{}
	mut iife_result_1 := iife_temp_1.get_authorization_url(rt.new_string(return_url))
	mut var_result := iife_result_1
	if !(!rt.is_true(var_result.array_get(rt.new_string('url')))) {
		var_result.array_set('url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'from', val: 'woocommerce-onboarding' }, rt.ArrayItem{ key: 'plugin_name', val: 'woocommerce-payments' }, rt.ArrayItem{ key: 'color_scheme', val: var_result.array_get(rt.new_string('color_scheme')) }]), var_result.array_get(rt.new_string('url'))]))
	}
	return var_result.clone()
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_jetpack_jetpackconnection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'order_map_apply_mappings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_apply_mappings(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'order_map_move_at_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_move_at_order(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'order_map_place_at_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_place_at_order(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'order_map_add_at_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_add_at_order(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'order_map_normalize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_normalize(mut dispatch_arg_0)
		}
		'order_map_change_min_order' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.order_map_change_min_order(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_testing_plugin_slug_suffixes' {
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_testing_plugin_slug_suffixes()
		}
		'generate_testing_plugin_slugs' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.generate_testing_plugin_slugs(dispatch_arg_0, dispatch_arg_1)
		}
		'normalize_plugin_slug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.normalize_plugin_slug(dispatch_arg_0))
		}
		'trim_php_file_extension' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.trim_php_file_extension(dispatch_arg_0))
		}
		'truncate_with_words' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.truncate_with_words(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'wc_payments_settings_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.wc_payments_settings_url(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'rest_endpoint_get_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.rest_endpoint_get_request(dispatch_arg_0, mut dispatch_arg_1)
		}
		'rest_endpoint_post_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Settings_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.rest_endpoint_post_request(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_wpcom_connection_authorization' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils.get_wpcom_connection_authorization(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Jetpack_JetpackConnection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
