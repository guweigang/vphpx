import rt

fn wc_rest_prepare_date_response(var_date rt.PhpVal, utc bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_date.is_long() || var_date.is_double())) {
		var_date = create_wc_datetime(rt.new_string("@${var_date.to_string()}"), create_datetimezone(rt.new_string('UTC')))
		var_date.settimezone(create_datetimezone(rt.call_function('wc_timezone_string', []rt.PhpVal{})))
	} else if rt.is_true(rt.new_bool(var_date.is_string())) {
		var_date = create_wc_datetime(var_date.dup(), create_datetimezone(rt.new_string('UTC')))
		var_date.settimezone(create_datetimezone(rt.call_function('wc_timezone_string', []rt.PhpVal{})))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_date, rt.new_string('WC_DateTime')]))))) {
		return rt.new_null()
	}
	return rt.call_function('gmdate', [rt.new_string('Y-m-d\\TH:i:s'), if var_utc { var_date.gettimestamp() } else { var_date.getoffsettimestamp() }])
}

fn wc_rest_allowed_image_mime_types() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_allowed_image_mime_types'), rt.create_array([rt.ArrayItem{ key: 'jpg|jpeg|jpe', val: 'image/jpeg' }, rt.ArrayItem{ key: 'gif', val: 'image/gif' }, rt.ArrayItem{ key: 'png', val: 'image/png' }, rt.ArrayItem{ key: 'bmp', val: 'image/bmp' }, rt.ArrayItem{ key: 'tiff|tif', val: 'image/tiff' }, rt.ArrayItem{ key: 'ico', val: 'image/x-icon' }, rt.ArrayItem{ key: 'webp', val: 'image/webp' }])])
}

fn wc_rest_upload_image_from_url(var_image_url rt.PhpVal) rt.PhpVal {
	mut var_parsed_url := rt.call_function('wp_parse_url', [var_image_url.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_parsed_url)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_url.dup().is_array()))))))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_image_url'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid URL %s.'), rt.new_string('woocommerce')]), var_image_url.dup()]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_image_url = rt.call_function('esc_url_raw', [var_image_url.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('download_url')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '2')
	}
	mut var_file_array := map[string]rt.PhpVal{}
	var_file_array['name'] = rt.call_function('basename', [rt.call_function('current', [rt.call_function('explode', [rt.new_string('?'), var_image_url.dup()])])])
	var_file_array['tmp_name'] = rt.call_function('download_url', [var_image_url.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_file_array.array_get('tmp_name')])) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_remote_image_url'), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error getting remote image %s.'), rt.new_string('woocommerce')]), var_image_url.dup()])).str() + ' ' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error: %s'), rt.new_string('woocommerce')]), rt.call_method(var_file_array.array_get('tmp_name'), 'get_error_message', []rt.PhpVal{})])).str(), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_file := rt.call_function('wp_handle_sideload', [var_file_array.dup(), rt.create_array([rt.ArrayItem{ key: 'test_form', val: false }, rt.ArrayItem{ key: 'mimes', val: wc_rest_allowed_image_mime_types() }]), rt.call_function('current_time', [rt.new_string('Y/m')])])
	if var_file.array_isset(rt.new_string('error')) {
		rt.call_function('unlink', [var_file_array.array_get('tmp_name')])
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_image'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid image: %s'), rt.new_string('woocommerce')]), var_file.array_get('error')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_api_uploaded_image_from_url'), var_file.dup(), var_image_url.dup()])
	return var_file.dup()
}

fn wc_rest_set_uploaded_image_as_attachment(var_upload rt.PhpVal, id i64) rt.PhpVal {
	mut var_info := rt.call_function('wp_check_filetype', [var_upload.array_get('file')])
	mut var_title := rt.new_string(rt.new_string(''))
	mut var_content := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_generate_attachment_metadata')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '2')
	}
	mut var_image_meta := rt.call_function('wp_read_image_metadata', [var_upload.array_get('file')])
	if rt.is_true(var_image_meta) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_string(var_image_meta.array_get('title').to_string().trim_space())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.call_function('sanitize_title', [var_image_meta.array_get('title')]).is_long() || rt.call_function('sanitize_title', [var_image_meta.array_get('title')]).is_double()))))))) {
			var_title = rt.call_function('wc_clean', [var_image_meta.array_get('title')])
		}
		if rt.is_true(rt.new_string(var_image_meta.array_get('caption').to_string().trim_space())) {
			var_content = rt.call_function('wc_clean', [var_image_meta.array_get('caption')])
		}
	}
	mut var_attachment := { 'post_mime_type': var_info.array_get('type'), 'guid': var_upload['url'], 'post_parent': rt.new_int(id), 'post_title': if rt.is_true(var_title) { var_title } else { rt.call_function('basename', [var_upload.array_get('file')]) }, 'post_content': var_content }
	mut var_attachment_id := rt.call_function('wp_insert_attachment', [var_attachment.dup(), var_upload.array_get('file'), rt.new_int(id)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_attachment_id.dup()]))))) {
		rt.call_function('wp_update_attachment_metadata', [var_attachment_id.dup(), rt.call_function('wp_generate_attachment_metadata', [var_attachment_id.dup(), var_upload.array_get('file')])])
	}
	return var_attachment_id.dup()
}

fn wc_rest_validate_reports_request_arg(var_value rt.PhpVal, var_request rt.PhpVal, var_param rt.PhpVal) bool {
	mut var_matches := rt.new_null()
	mut var_attributes := rt.call_method(var_request, 'get_attributes', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(var_attributes.array_get('args').array_isset(var_param)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_attributes.array_get('args').array_get(var_param).is_array()))))))) {
		return true
	}
	mut var_args := var_attributes.array_get('args').array_get(var_param)
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('string'), var_args.array_get('type'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_string()))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s is not of type %2$s'), rt.new_string('woocommerce')]), var_param.dup(), rt.new_string('string')]))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('date'), var_args.array_get('format'))) {
		mut var_regex := '#^\\d{4}-\\d{2}-\\d{2}$#'
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string(var_regex).dup(), var_value.dup(), var_matches.dup()]))))) {
			return (create_wp_error(rt.new_string('woocommerce_rest_invalid_date'), rt.call_function('__', [rt.new_string('The date you provided is invalid.'), rt.new_string('woocommerce')]))).to_bool()
		}
	}
	return true
}

fn wc_rest_urlencode_rfc3986(var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
		return rt.call_function('array_map', [rt.new_string('wc_rest_urlencode_rfc3986'), var_value.dup()])
	}
	return rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '%7E' }]), rt.create_array([rt.ArrayItem{ key: none, val: ' ' }, rt.ArrayItem{ key: none, val: '~' }]), rt.call_function('rawurlencode', [var_value.dup()])])
}

fn wc_rest_check_post_permissions(var_post_type rt.PhpVal, context string, object_id i64) rt.PhpVal {
	mut var_contexts := rt.create_array([rt.ArrayItem{ key: 'read', val: 'read_private_posts' }, rt.ArrayItem{ key: 'create', val: 'publish_posts' }, rt.ArrayItem{ key: 'edit', val: 'edit_post' }, rt.ArrayItem{ key: 'delete', val: 'delete_post' }, rt.ArrayItem{ key: 'batch', val: 'edit_others_posts' }])
	if rt.is_true(rt.identical(rt.new_string('revision'), var_post_type)) {
		mut var_permission := rt.new_bool(rt.new_bool(false))
	} else {
		mut var_cap := var_contexts.array_get(context)
		mut var_post_type_object := rt.call_function('get_post_type_object', [var_post_type.dup()])
		var_permission = rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.new_bool(rt.instance_of(var_post_type_object, 'WP_Post_Type'))) {
			var_permission = rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type_object, 'cap'), '{"nodeType":"Expr_Variable","line":245,"name":"cap"}'), rt.new_int(object_id)])
		}
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.dup(), rt.new_string(context), rt.new_int(object_id), var_post_type.dup()])
}

fn wc_rest_check_user_permissions(context string, object_id i64) rt.PhpVal {
	mut var_contexts := rt.create_array([rt.ArrayItem{ key: 'read', val: 'list_users' }, rt.ArrayItem{ key: 'create', val: 'create_customers' }, rt.ArrayItem{ key: 'edit', val: 'edit_users' }, rt.ArrayItem{ key: 'delete', val: 'delete_users' }, rt.ArrayItem{ key: 'batch', val: 'promote_users' }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('in_array', [rt.new_string(context), rt.create_array([rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'delete' }]), rt.new_bool(true)])) && rt.is_true(rt.call_function('wc_current_user_has_role', [rt.new_string('shop_manager')])))) {
		mut var_permission := rt.new_bool(rt.new_bool(false))
		mut var_user_data := rt.call_function('get_userdata', [rt.new_int(object_id)])
		mut var_shop_manager_editable_roles := rt.call_function('apply_filters', [rt.new_string('woocommerce_shop_manager_editable_roles'), rt.create_array([rt.ArrayItem{ key: none, val: 'customer' }])])
		if !(rt.get_property(var_user_data, 'roles')).is_null() {
			mut var_can_manage_users := rt.call_function('array_intersect', [rt.get_property(var_user_data, 'roles'), rt.call_function('array_unique', [var_shop_manager_editable_roles.dup()])])
			if 0 < var_can_manage_users.dup().array_count() || rt.new_int(object_id).to_i64() == rt.call_function('get_current_user_id', []rt.PhpVal{}).to_i64() {
				var_permission = rt.call_function('current_user_can', [var_contexts.array_get(context), rt.new_int(object_id)])
			}
		}
	} else {
		var_permission = rt.call_function('current_user_can', [var_contexts.array_get(context), rt.new_int(object_id)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_permission) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_Users{}; return temp.get_user_in_current_site(arg_0) }(rt.new_int(object_id)))))))) {
		var_permission = rt.new_bool(rt.new_bool(false))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.dup(), rt.new_string(context), rt.new_int(object_id), rt.new_string('user')])
}

fn wc_rest_check_product_term_permissions(var_taxonomy rt.PhpVal, context string, object_id i64) rt.PhpVal {
	mut var_contexts := rt.create_array([rt.ArrayItem{ key: 'read', val: 'manage_terms' }, rt.ArrayItem{ key: 'create', val: 'edit_terms' }, rt.ArrayItem{ key: 'edit', val: 'edit_terms' }, rt.ArrayItem{ key: 'delete', val: 'delete_terms' }, rt.ArrayItem{ key: 'batch', val: 'edit_terms' }])
	mut var_cap := var_contexts.array_get(context)
	mut var_taxonomy_object := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	mut var_permission := rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy_object, 'cap'), '{"nodeType":"Expr_Variable","line":328,"name":"cap"}'), rt.new_int(object_id)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.dup(), rt.new_string(context), rt.new_int(object_id), var_taxonomy.dup()])
}

fn wc_rest_check_manager_permissions(var_object rt.PhpVal, context string) rt.PhpVal {
	mut var_objects := rt.create_array([rt.ArrayItem{ key: 'reports', val: 'view_woocommerce_reports' }, rt.ArrayItem{ key: 'settings', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'system_status', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'attributes', val: 'manage_product_terms' }, rt.ArrayItem{ key: 'shipping_methods', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'payment_gateways', val: 'manage_woocommerce' }, rt.ArrayItem{ key: 'webhooks', val: 'manage_woocommerce' }])
	mut var_permission := rt.call_function('current_user_can', [var_objects.array_get(var_object)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.dup(), rt.new_string(context), rt.new_int(0), var_object.dup()])
}

fn wc_rest_check_product_reviews_permissions(context string, object_id i64) bool {
	mut var_permission := rt.new_bool(rt.new_bool(false))
	mut var_contexts := rt.create_array([rt.ArrayItem{ key: 'read', val: 'moderate_comments' }, rt.ArrayItem{ key: 'create', val: 'edit_products' }, rt.ArrayItem{ key: 'edit', val: 'edit_products' }, rt.ArrayItem{ key: 'delete', val: 'edit_products' }, rt.ArrayItem{ key: 'batch', val: 'edit_products' }])
	if object_id > 0 {
		mut var_object := rt.call_function('get_comment', [rt.new_int(object_id)])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_object.dup(), rt.new_string('WP_Comment')]))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return false
		}
	}
	if var_contexts.array_isset(rt.new_string(context)) {
		var_permission = rt.call_function('current_user_can', [var_contexts.array_get(context), rt.new_int(object_id)])
	}
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_check_permissions'), var_permission.dup(), rt.new_string(context), rt.new_int(object_id), rt.new_string('product_review')])).to_bool()
}

fn wc_rest_is_from_product_editor() bool {
	return rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_X_WC_FROM_PRODUCT_EDITOR')) && rt.is_true(rt.identical(rt.new_string('1'), rt.get_superglobal('_SERVER').array_get('HTTP_X_WC_FROM_PRODUCT_EDITOR')))
}

fn wc_rest_should_load_namespace(ns string, rest_route string) bool {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(rest_route))) {
		rest_route = (if !(rt.get_property(var_GLOBALS.array_get('wp'), 'query_vars').array_get('rest_route')).is_null() { rt.get_property(var_GLOBALS.array_get('wp'), 'query_vars').array_get('rest_route') } else { rt.new_string('') }).str()
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(rest_route))) {
		return true
	}
	rest_route = (rt.call_function('trailingslashit', [rt.new_string(rest_route.trim_left(' \t\n\r'))])).str()
	ns = (rt.call_function('trailingslashit', [rt.new_string(ns)])).str()
	mut var_known_namespaces := ['wc/v1', 'wc/v2', 'wc/v3', 'wc/v4', 'wc-telemetry', 'wc-admin', 'wc-analytics', 'wc/store', 'wc/private']
	mut var_known_namespace_request := false
	for var_known_namespace in var_known_namespaces {
		if rt.is_true(rt.call_function('str_starts_with', [rt.new_string(rest_route), rt.new_string(known_namespace)])) {
			var_known_namespace_request = true
			break
		}
	}
	if !(var_known_namespace_request) {
		return true
	}
	return (rt.call_function('apply_filters', [rt.new_string('wc_rest_should_load_namespace'), rt.call_function('str_starts_with', [rt.new_string(rest_route), rt.new_string(ns)]), rt.new_string(ns), rt.new_string(rest_route), var_known_namespaces.dup()])).to_bool()
}

struct Class_WC_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_Users {
	rt.PhpObjectBase
}

fn create_wc_datetime() &Class_WC_DateTime {
	mut obj := &Class_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
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

fn create_automattic_woocommerce_internal_utilities_users() &Class_Automattic_WooCommerce_Internal_Utilities_Users {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_Users{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_wc_rest_functions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
