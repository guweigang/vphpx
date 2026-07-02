import rt

struct Class_WC_Admin_Addons {
	rt.PhpObjectBase
}

fn Class_WC_Admin_Addons.fetch_featured() rt.PhpVal {
	mut var_transient_name := rt.new_string('wc_addons_featured')
	mut var_url := rt.new_string('https://woocommerce.com/wp-json/wccom-extensions/4.0/featured')
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_featured := Class_WC_Admin_Addons.get_locale_data_from_transient(var_transient_name.clone(),
		var_locale.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_featured)) {
		mut var_fetch_options := {
			'auth':    true
			'locale':  true
			'country': true
		}
		mut var_raw_featured := Class_WC_Admin_Addons.fetch(var_url.clone(),
			var_fetch_options.clone())
		var_featured = Class_WC_Admin_Addons.process_api_response(var_raw_featured.str(),
			'featured')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_featured.clone()])))))
			&& rt.is_true(var_featured) {
			Class_WC_Admin_Addons.set_locale_data_in_transient(var_transient_name.to_i64(),
				var_featured.clone(), var_locale.clone(), rt.get_constant('DAY_IN_SECONDS'))
		}
	}
	return var_featured.clone()
}

fn Class_WC_Admin_Addons.fetch_product_preview(product_id i64) rt.PhpVal {
	mut var_url := rt.new_string(
		'https://woocommerce.com/wp-json/wccom-extensions/1.0/product-previews?product_id=' +
		product_id.str())
	mut var_fetch_options := {
		'locale': true
	}
	mut var_raw_preview := Class_WC_Admin_Addons.fetch(var_url.clone(), var_fetch_options.clone())
	return Class_WC_Admin_Addons.process_api_response(var_raw_preview.str(), 'product preview',
		rt.new_bool(true))
}

fn Class_WC_Admin_Addons.is_ssl_error(var_error_message rt.PhpVal) bool {
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_error_message.clone(),
		rt.new_string('cURL error 35'),
	]))))
}

fn Class_WC_Admin_Addons.get_sections() rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_addon_sections := Class_WC_Admin_Addons.get_locale_data_from_transient(rt.new_string('wc_addons_sections'),
		var_locale.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_addon_sections)) {
		mut var_parameter_string := rt.new_string('?' +(rt.call_function('http_build_query', [rt.create_array([rt.ArrayItem{
			key: 'locale'
			val: rt.call_function('get_user_locale', []rt.PhpVal{})
		}])])).str())
		mut var_raw_sections := rt.call_function('wp_safe_remote_get', [
			rt.new_string('https://woocommerce.com/wp-json/wccom-extensions/1.0/categories' +
				var_parameter_string.str()),
			rt.create_array([
				rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
					(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() +
					'; ' + (rt.call_function('get_bloginfo', [rt.new_string('url')])).str() },
			]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_raw_sections.clone(),
		])))))
		{
			var_addon_sections = rt.call_function('json_decode', [
				rt.call_function('wp_remote_retrieve_body', [
					var_raw_sections.clone()]),
			])
			if rt.is_true(var_addon_sections) {
				Class_WC_Admin_Addons.set_locale_data_in_transient('wc_addons_sections',
					var_addon_sections.clone(), var_locale.clone(),
					rt.get_constant('WEEK_IN_SECONDS'))
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_addons_sections'),
		var_addon_sections.clone(),
	])
}

fn Class_WC_Admin_Addons.get_section(var_section_id rt.PhpVal) bool {
	mut var_sections := Class_WC_Admin_Addons.get_sections()
	if var_sections.array_isset(var_section_id) {
		return (var_sections.array_get(var_section_id)).to_bool()
	}
	return false
}

fn Class_WC_Admin_Addons.get_in_app_purchase_url_params() rt.PhpVal {
	mut var_back_admin_path := rt.call_function('add_query_arg', [
		rt.new_array()])
	return rt.create_array([
		rt.ArrayItem{ key: 'wccom-site', val: rt.call_function('site_url', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'wccom-back', val: rt.call_function('rawurlencode', [
			var_back_admin_path.clone(),
		]) },
		rt.ArrayItem{ key: 'wccom-woo-version', val: rt.call_method(rt.call_function('WC',
			[]rt.PhpVal{}), 'stable_version', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'wccom-connect-nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('connect'),
		]) },
	])
}

fn Class_WC_Admin_Addons.add_in_app_purchase_url_params(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	return rt.call_function('add_query_arg', [
		Class_WC_Admin_Addons.get_in_app_purchase_url_params(),
		var_url_mutated.clone(),
	])
}

fn Class_WC_Admin_Addons.output_button(var_url rt.PhpVal, var_text rt.PhpVal, var_style rt.PhpVal, plugin string) {
	mut var_url_mutated := var_url
	mut var_text_mutated := var_text
	mut var_style_mutated := var_style
	var_style_mutated = if rt.is_true(rt.identical(rt.call_function('__', [
		rt.new_string('Free'),
		rt.new_string('woocommerce'),
	]), var_text_mutated))
	{ rt.new_string('addons-button-outline-purple') } else { var_style_mutated }
	var_style_mutated = if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string(plugin),
	]))
	{ rt.new_string('addons-button-installed') } else { var_style_mutated }
	var_text_mutated = if rt.is_true(rt.call_function('is_plugin_active', [
		rt.new_string(plugin),
	]))
	{
		rt.call_function('__', [rt.new_string('Installed'), rt.new_string('woocommerce')])
	} else {
		var_text_mutated
	}
	var_url_mutated = Class_WC_Admin_Addons.add_in_app_purchase_url_params(var_url_mutated.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_style_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_url_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_text_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Admin_Addons.handle_legacy_marketplace_redirects() {
	mut var_section_object := rt.new_null()
	mut var_section := if rt.get_superglobal('_GET').array_isset(rt.new_string('section')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('section'))]),
		]) } else { rt.new_string('_featured') }
	mut var_search := if rt.get_superglobal('_GET').array_isset(rt.new_string('search')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('search'))]),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.identical(rt.new_string('helper'), var_section)) {
		mut var_url := rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-admin&tab=my-subscriptions&path=%2Fextensions'),
		])
		if rt.get_superglobal('_GET').array_isset(rt.new_string('connect')) {
			var_url = rt.concat(var_url, rt.new_string('&connect'))
		}
		rt.call_function('wp_safe_redirect', [var_url.clone()])
		exit(0)
	}
	if rt.is_true(rt.identical(rt.new_string('search'), var_section)) || !(!rt.is_true(var_search)) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-admin&term=' + var_search.str() +
					'&tab=search&path=%2Fextensions'),
			]),
		])
		exit(0)
	}
	mut var_sections := Class_WC_Admin_Addons.get_sections()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_section_object := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_section_object, 'slug')
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_section_object := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.get_property(var_section_object, 'slug')
	}
	mut var_allowed_sections := rt.call_function('array_map', [
		rt.new_closure(closure_1_fn),
		var_sections.clone(),
	])
	var_section = if rt.is_true(rt.call_function('in_array', [
		var_section.clone(), var_allowed_sections.clone(), rt.new_bool(true)]))
	{ var_section } else { rt.new_string('_featured') }
	if rt.is_true(rt.identical(rt.new_string('_featured'), var_section)) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-admin&path=%2Fextensions'),
			]),
		])
		exit(0)
	}
	rt.call_function('wp_safe_redirect', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-admin&tab=extensions&path=%2Fextensions&category=' +
				var_section.str()),
		]),
	])
	exit(0)
}

fn Class_WC_Admin_Addons.filter_admin_body_classes(admin_body_class string) string {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('section'))
		&& rt.is_true(rt.identical(rt.new_string('helper'), rt.get_superglobal('_GET').array_get(rt.new_string('section')))) {
		return ' ${var_admin_body_class} woocommerce-page-wc-subscriptions '
	}
	return ' ${var_admin_body_class} woocommerce-page-wc-marketplace '
}

fn Class_WC_Admin_Addons.get_action_url(var_action rt.PhpVal) string {
	if !(!(rt.get_property(var_action, 'url')).is_null()) {
		return ''
	}
	if !(rt.get_property(var_action, 'url_is_admin_query')).is_null()
		&& rt.is_true(rt.get_property(var_action, 'url_is_admin_query')) {
		return (rt.call_function('wc_admin_url', [rt.get_property(var_action, 'url')])).str()
	}
	if !(rt.get_property(var_action, 'url_is_admin_nonce_query')).is_null()
		&& rt.is_true(rt.get_property(var_action, 'url_is_admin_nonce_query')) {
		if !rt.is_true(rt.get_property(var_action, 'nonce')) {
			return ''
		}
		return (rt.call_function('wp_nonce_url', [
			rt.call_function('admin_url', [rt.get_property(var_action, 'url')]),
			rt.get_property(var_action, 'nonce'),
		])).str()
	}
	return (rt.get_property(var_action, 'url')).str()
}

fn Class_WC_Admin_Addons.get_locale_data_from_transient(var_transient rt.PhpVal, var_locale rt.PhpVal) rt.PhpVal {
	mut var_locale_mutated := var_locale
	mut var_transient_value := rt.call_function('get_transient', [
		var_transient.clone()])
	var_transient_value = if var_transient_value.clone().is_array() {
		var_transient_value
	} else {
		rt.new_array()
	}
	return if !(var_transient_value.array_get(var_locale_mutated)).is_null() {
		var_transient_value.array_get(var_locale_mutated)
	} else {
		rt.new_bool(false)
	}
}

fn Class_WC_Admin_Addons.set_locale_data_in_transient(var_transient rt.PhpVal, var_value rt.PhpVal, var_locale rt.PhpVal, expiration i64) rt.PhpVal {
	mut var_locale_mutated := var_locale
	mut var_transient_value := rt.call_function('get_transient', [
		var_transient.clone()])
	var_transient_value = if var_transient_value.clone().is_array() {
		var_transient_value
	} else {
		rt.new_array()
	}
	var_transient_value.array_set(var_locale_mutated, var_value.clone())
	return rt.call_function('set_transient', [var_transient.clone(),
		var_transient_value.clone(), rt.new_int(expiration)])
}

fn Class_WC_Admin_Addons.process_api_response(var_response rt.PhpVal, context string, associative bool) rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_page_wc_addons_connection_error'),
			rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}),
		])
		mut var_message := if rt.is_true(Class_WC_Admin_Addons.is_ssl_error(rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}))) { rt.call_function('__', [
				rt.new_string('We encountered an SSL error. Please ensure your site supports TLS version 1.2 or above.'),
				rt.new_string('woocommerce'),
			]) } else { rt.call_method(var_response, 'get_error_message', []rt.PhpVal{}) }
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc-addons-connection-error'),
			var_message.clone()))
	}
	mut var_response_code := rt.new_int((rt.call_function('wp_remote_retrieve_response_code', [
		var_response.clone(),
	])).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), var_response_code)))) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_page_wc_addons_connection_error'),
			var_response_code.clone(),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Our request to the %1$s API got error code %2$d.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string(context),
			var_response_code.clone(),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc-addons-connection-error'),
			var_message.clone()))
	}
	mut var_data := rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_response.clone()]),
		rt.new_bool(associative),
	])
	if !rt.is_true(var_data) || !(var_data.clone().is_array()) {
		rt.call_function('do_action', [
			rt.new_string('woocommerce_page_wc_addons_connection_error'),
			rt.new_string('Empty or malformed response'),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Our request to the %s API got a malformed response.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string(context),
		])
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('wc-addons-connection-error'),
			var_message.clone()))
	}
	return var_data.clone()
}

fn Class_WC_Admin_Addons.fetch(var_url rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_headers := rt.new_array()
	if var_options.array_isset(rt.new_string('auth'))
		&& rt.is_true(var_options.array_get(rt.new_string('auth'))) {
		mut iife_temp_2 := Class_WC_Helper_Options{}
		mut iife_result_2 := iife_temp_2.get(rt.new_string('auth'))
		mut var_auth := iife_result_2
		if var_auth.array_isset(rt.new_string('access_token'))
			&& !(!rt.is_true(var_auth.array_get(rt.new_string('access_token')))) {
			var_headers['Authorization'] = 'Bearer ' +
				(var_auth.array_get(rt.new_string('access_token'))).str()
		}
	}
	mut var_parameters := rt.new_array()
	if var_options.array_isset(rt.new_string('locale'))
		&& rt.is_true(var_options.array_get(rt.new_string('locale'))) {
		var_parameters['locale'] = rt.call_function('get_user_locale', []rt.PhpVal{})
	}
	if var_options.array_isset(rt.new_string('country'))
		&& rt.is_true(var_options.array_get(rt.new_string('country'))) {
		mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'countries'), 'get_base_country', []rt.PhpVal{})
		if !(!rt.is_true(var_country)) {
			var_parameters['country'] = var_country.clone()
		}
	}
	mut var_connector := rt.new_string((if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_url_mutated.clone(),
		rt.new_string('?'),
	]), rt.new_bool(false)))))
	{ '&' } else { '?' }).str())
	mut var_query_string := rt.new_string((if !(!rt.is_true(var_parameters)) {
		var_connector.str() +(rt.call_function('http_build_query', [rt.create_array_from_native_map(var_parameters)])).str()
	} else {
		''
	}).str())
	return rt.call_function('wp_safe_remote_get', [
		rt.new_string(var_url_mutated.str() + var_query_string.str()),
		rt.create_array([rt.ArrayItem{ key: 'headers', val: var_headers },
			rt.ArrayItem{ key: 'user-agent', val: 'WooCommerce/' +
				(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')).str() + '; ' +
				(rt.call_function('get_bloginfo', [rt.new_string('url')])).str() }]),
	])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Helper_Options {
	rt.PhpObjectBase
}

fn create_wc_admin_addons(_args ...rt.PhpVal) &Class_WC_Admin_Addons {
	mut obj := &Class_WC_Admin_Addons{
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

fn create_wc_helper_options(_args ...rt.PhpVal) &Class_WC_Helper_Options {
	mut obj := &Class_WC_Helper_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Admin_Addons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'fetch_featured' {
			return Class_WC_Admin_Addons.fetch_featured()
		}
		'fetch_product_preview' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_WC_Admin_Addons.fetch_product_preview(dispatch_arg_0)
		}
		'is_ssl_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Admin_Addons.is_ssl_error(dispatch_arg_0))
		}
		'get_sections' {
			return Class_WC_Admin_Addons.get_sections()
		}
		'get_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Admin_Addons.get_section(dispatch_arg_0))
		}
		'get_in_app_purchase_url_params' {
			return Class_WC_Admin_Addons.get_in_app_purchase_url_params()
		}
		'add_in_app_purchase_url_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Admin_Addons.add_in_app_purchase_url_params(dispatch_arg_0)
		}
		'output_button' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			Class_WC_Admin_Addons.output_button(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
			return rt.new_null()
		}
		'handle_legacy_marketplace_redirects' {
			Class_WC_Admin_Addons.handle_legacy_marketplace_redirects()
			return rt.new_null()
		}
		'filter_admin_body_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_WC_Admin_Addons.filter_admin_body_classes(dispatch_arg_0))
		}
		'get_action_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Admin_Addons.get_action_url(dispatch_arg_0))
		}
		'get_locale_data_from_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Admin_Addons.get_locale_data_from_transient(dispatch_arg_0,
				dispatch_arg_1)
		}
		'set_locale_data_in_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_WC_Admin_Addons.set_locale_data_in_transient(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'process_api_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return Class_WC_Admin_Addons.process_api_response(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'fetch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Admin_Addons.fetch(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Addons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Addons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Helper_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
