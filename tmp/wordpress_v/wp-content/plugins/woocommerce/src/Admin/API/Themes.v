import rt

struct Class_Automattic_WooCommerce_Admin_API_Themes {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('themes')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Themes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'upload_theme' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Themes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'upload_theme_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_Themes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) upload_theme_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_themes')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to install themes on this site.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) upload_theme(var_request rt.PhpVal) rt.PhpVal {
	mut var__FILES := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var__FILES.array_isset(rt.new_string('pluginzip'))) || !(var__FILES.array_get('pluginzip').array_isset(rt.new_string('tmp_name'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_uploaded_file', [var__FILES.array_get('pluginzip').array_get('tmp_name')]))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var__FILES.array_get('pluginzip').array_get('tmp_name')]))))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_file'), rt.call_function('__', [rt.new_string('Specified file failed upload test.'), rt.new_string('woocommerce')]))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/admin.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/theme-install.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/theme.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-wp-upgrader.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-theme-upgrader.php', '2')
	rt.get_superglobal('_GET').array_set('package', true)
	mut var_file_upload := create_automattic_woocommerce_admin_api_file_upload_upgrader(rt.new_string('pluginzip'), rt.new_string('package'))
	mut var_upgrader := create_automattic_woocommerce_admin_overrides_themeupgrader(create_automattic_woocommerce_admin_overrides_themeupgraderskin())
	mut var_install := var_upgrader.install(rt.get_property(var_file_upload, 'package'))
	if rt.is_true(rt.new_bool(rt.is_true(var_install) || rt.is_true(rt.call_function('is_wp_error', [var_install.dup()])))) {
		var_file_upload.cleanup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_install.dup()]))))) && var_install.array_isset(rt.new_string('destination_name')))) {
		mut var_theme := var_install.array_get('destination_name')
		mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: rt.get_property(var_upgrader, 'strings').array_get('process_success') }, rt.ArrayItem{ key: 'theme', val: var_theme }])
		rt.call_function('do_action', [rt.new_string('woocommerce_theme_installed'), var_theme.dup()])
	} else {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_install.dup()])) && rt.is_true(rt.call_method(var_install, 'get_error_code', []rt.PhpVal{})))) {
			mut var_error_message := if rt.get_property(var_upgrader, 'strings').array_isset(rt.call_method(var_install, 'get_error_code', []rt.PhpVal{})) { rt.get_property(var_upgrader, 'strings').array_get(rt.call_method(var_install, 'get_error_code', []rt.PhpVal{})) } else { rt.call_method(var_install, 'get_error_data', []rt.PhpVal{}) }
		} else {
			var_error_message = rt.get_property(var_upgrader, 'strings').array_get('process_failed')
		}
		var_result = rt.create_array([rt.ArrayItem{ key: 'status', val: 'error' }, rt.ArrayItem{ key: 'message', val: var_error_message }])
	}
	mut var_response := this.prepare_item_for_response(var_result.dup(), var_request.dup())
	mut var_data := this.prepare_response_for_collection(var_response.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := this.add_additional_fields_to_object(var_item.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), rt.new_string('view'))
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_themes'), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'upload_theme' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Theme installation status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Theme installation message.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'theme', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Uploaded theme.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) get_collection_params() rt.PhpVal {
	mut var_params := rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
	var_params.array_set('pluginzip', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A zip file of the theme to be uploaded.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'file' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_themes_collection_params'), var_params.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_themes() &Class_Automattic_WooCommerce_Admin_API_Themes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Themes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('themes')
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_file_upload_upgrader() &Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_themeupgrader() &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_themeupgraderskin() &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'upload_theme_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.upload_theme_permissions_check(dispatch_arg_0))
		}
		'upload_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.upload_theme(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Themes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Themes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_File_Upload_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_themes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
