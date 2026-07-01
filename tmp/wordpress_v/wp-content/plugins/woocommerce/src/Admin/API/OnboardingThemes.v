import rt

struct Class_Automattic_WooCommerce_Admin_API_OnboardingThemes {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('onboarding/themes')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/install', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'install_theme' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/activate', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'activate_theme' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingThemes', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('Sorry, you cannot manage themes.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) install_theme(var_request rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.call_function('sanitize_text_field', [var_request.array_get('theme')])
	mut var_installed_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [var_theme.dup(), rt.func_array_keys(var_installed_themes.dup()), rt.new_bool(true)])) {
		return rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_installed_themes.array_get(var_theme), 'get', [rt.new_string('Name')]) }, rt.ArrayItem{ key: 'status', val: 'success' }])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/admin.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/theme-install.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/theme.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-wp-upgrader.php', '2')
	rt.include_file((rt.get_constant('ABSPATH')).str() + '/wp-admin/includes/class-theme-upgrader.php', '2')
	mut var_api := rt.call_function('themes_api', [rt.new_string('theme_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }]) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_theme_install'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested theme `%s` could not be installed. Theme API call failed.'), rt.new_string('woocommerce')]), var_theme.dup()]), rt.new_int(500))
	}
	mut var_upgrader := create_automattic_woocommerce_admin_api_theme_upgrader(create_automattic_woocommerce_admin_api_automatic_upgrader_skin())
	mut var_result := var_upgrader.install(rt.get_property(var_api, 'download_link'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) || rt.is_true(rt.new_bool(var_result.dup().is_null())))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_theme_install'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested theme `%s` could not be installed.'), rt.new_string('woocommerce')]), var_theme.dup()]), rt.new_int(500))
	}
	return rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_api, 'name') }, rt.ArrayItem{ key: 'status', val: 'success' }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) activate_theme(var_request rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.call_function('sanitize_text_field', [var_request.array_get('theme')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	mut var_installed_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_theme.dup(), rt.func_array_keys(var_installed_themes.dup()), rt.new_bool(true)]))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_theme'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid theme %s.'), rt.new_string('woocommerce')]), var_theme.dup()]), rt.new_int(404))
	}
	mut var_result := rt.call_function('switch_theme', [var_theme.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_result.dup().is_null()))))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_theme'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The requested theme could not be activated.'), rt.new_string('woocommerce')]), var_theme.dup()]), rt.new_int(500))
	}
	return rt.create_array([rt.ArrayItem{ key: 'slug', val: var_theme }, rt.ArrayItem{ key: 'name', val: rt.call_method(var_installed_themes.array_get(var_theme), 'get', [rt.new_string('Name')]) }, rt.ArrayItem{ key: 'status', val: 'success' }])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'onboarding_theme' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Theme slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Theme name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Theme status.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }])
	return this.add_additional_fields_schema(var_schema.dup())
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_onboardingthemes() &Class_Automattic_WooCommerce_Admin_API_OnboardingThemes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_OnboardingThemes{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('onboarding/themes')
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

fn create_automattic_woocommerce_admin_api_theme_upgrader() &Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_automatic_upgrader_skin() &Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'install_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.install_theme(dispatch_arg_0)
		}
		'activate_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.activate_theme(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingThemes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Automatic_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_onboardingthemes_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
