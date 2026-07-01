import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager {
	rt.PhpObjectBase
pub mut:
		settings_controller rt.PhpVal = rt.new_null()
		theme_controller rt.PhpVal = rt.new_null()
		user_theme rt.PhpVal = rt.new_null()
		assets_path rt.PhpVal = rt.new_string('')
		assets_url rt.PhpVal = rt.new_string('')
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) construct(mut var_settings_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller, mut var_theme_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller, mut var_user_theme Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme, mut var_logger Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger)  {
	this.settings_controller = var_settings_controller.dup()
	this.theme_controller = var_theme_controller.dup()
	this.user_theme = var_user_theme.dup()
	this.logger = var_logger.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) set_assets_path(assets_path string)  {
	this.assets_path = rt.new_string(assets_path).dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) set_assets_url(assets_url string)  {
	this.assets_url = rt.new_string(assets_url).dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) initialize()  {
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_admin_styles' }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) enqueue_admin_styles()  {
	rt.call_function('do_action', [rt.new_string('enqueue_block_editor_assets')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-edit-post')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-format-library')])
	rt.call_function('wp_enqueue_global_styles_css_custom_properties', []rt.PhpVal{})
	rt.call_function('wp_enqueue_media', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) render_email_editor_html(element_id string)  {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	print('<div id="' + (rt.call_function('esc_attr', [rt.new_string(element_id)])).str() + '" class="block-editor block-editor__container hide-if-no-js"></div>')
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) load_editor_assets(var_edited_item rt.PhpVal, script_name string)  {
	mut var_post_type := if rt.is_true(rt.new_bool(rt.instance_of(var_edited_item, 'Automattic_WooCommerce_EmailEditor_Engine_WP_Post'))) { rt.get_property(var_edited_item, 'post_type') } else { rt.new_string('wp_template') }
	mut var_post_id := if rt.is_true(rt.new_bool(rt.instance_of(var_edited_item, 'Automattic_WooCommerce_EmailEditor_Engine_WP_Post'))) { rt.get_property(var_edited_item, 'ID') } else { rt.get_property(var_edited_item, 'id') }
	mut var_email_editor_assets_path := rt.new_string(this.assets_path.to_string().trim_right(' \t\n\r') + '/')
	mut var_email_editor_assets_url := rt.new_string(this.assets_url.to_string().trim_right(' \t\n\r') + '/')
	mut var_assets_file := rt.new_string((var_email_editor_assets_path).str() + 'style.asset.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_assets_file.dup()]))))) {
		rt.call_method(this.logger, 'error', [rt.new_string('Email editor assets file does not exist.'), rt.create_array([rt.ArrayItem{ key: 'path', val: var_assets_file }])])
	} else {
		var_assets_file = rt.include_file((var_assets_file).to_string(), '3')
		rt.call_function('wp_enqueue_style', [rt.new_string('wc-admin-email-editor-integration'), (var_email_editor_assets_url).str() + 'style.css', rt.new_array(), var_assets_file.array_get('version')])
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_edited_item, 'Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Template'))) {
		mut var_context := create_automattic_woocommerce_emaileditor_engine_wp_block_editor_context(rt.create_array([rt.ArrayItem{ key: 'post', val: var_edited_item }]))
	} else {
		var_context = var_edited_item
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'), rt.call_function('sprintf', [rt.new_string('wp.blocks.setCategories( %s );'), rt.call_function('wp_json_encode', [rt.call_function('get_block_categories', [var_context.dup()]), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])]), rt.new_string('after')])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'), rt.call_function('sprintf', [rt.new_string('wp.blocks.unstable__bootstrapServerSideBlockDefinitions( %s );'), rt.call_function('wp_json_encode', [rt.call_function('get_block_editor_server_block_settings', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
	mut var_localization_data := rt.create_array([rt.ArrayItem{ key: 'current_post_type', val: var_post_type }, rt.ArrayItem{ key: 'current_post_id', val: var_post_id }, rt.ArrayItem{ key: 'current_wp_user_email', val: rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'user_email') }, rt.ArrayItem{ key: 'editor_settings', val: rt.call_method(this.settings_controller, 'get_settings', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'editor_theme', val: rt.call_method(rt.call_method(this.theme_controller, 'get_base_theme', []rt.PhpVal{}), 'get_raw_data', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'user_theme_post_id', val: rt.get_property(rt.call_method(this.user_theme, 'get_user_theme_post', []rt.PhpVal{}), 'ID') }, rt.ArrayItem{ key: 'urls', val: rt.create_array([rt.ArrayItem{ key: 'listings', val: rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email')]) }, rt.ArrayItem{ key: 'send', val: rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email')]) }, rt.ArrayItem{ key: 'back', val: rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=email')]) }, rt.ArrayItem{ key: 'createCoupon', val: rt.call_function('admin_url', [rt.new_string('post-new.php?post_type=shop_coupon')]) }]) }])
	rt.call_function('wp_localize_script', [rt.new_string(script_name), rt.new_string('WooCommerceEmailEditor'), rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_script_localization_data'), var_localization_data.dup()])])
	this.preload_rest_api_data(var_post_id.dup(), (var_post_type).str())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) preload_rest_api_data(var_post_id rt.PhpVal, post_type string)  {
	mut var_post_id_mutated := var_post_id
	mut post_type_mutated := post_type
	mut var_email_post_type := rt.new_string(rt.new_string(post_type_mutated)).dup()
	mut var_user_theme_post_id := rt.get_property(rt.call_method(this.user_theme, 'get_user_theme_post', []rt.PhpVal{}), 'ID')
	mut var_template_slug := rt.call_function('get_post_meta', [// unsupported expression: Expr_Cast_Int, rt.new_string('_wp_page_template'), rt.new_bool(true)])
	mut var_routes := rt.create_array([rt.ArrayItem{ key: none, val: "/wp/v2/${var_email_post_type.to_string()}/" + var_post_id_mutated.dup().to_i64().str() + '?context=edit' }, rt.ArrayItem{ key: none, val: "/wp/v2/types/${var_email_post_type.to_string()}?context=edit" }, rt.ArrayItem{ key: none, val: '/wp/v2/global-styles/' + var_user_theme_post_id.dup().to_i64().str() + '?context=view' }, rt.ArrayItem{ key: none, val: '/wp/v2/block-patterns/patterns' }, rt.ArrayItem{ key: none, val: '/wp/v2/templates?context=view' }, rt.ArrayItem{ key: none, val: '/wp/v2/block-patterns/categories' }, rt.ArrayItem{ key: none, val: '/wp/v2/settings' }, rt.ArrayItem{ key: none, val: '/wp/v2/types?context=view' }, rt.ArrayItem{ key: none, val: '/wp/v2/taxonomies?context=view' }])
	if rt.is_true(rt.new_bool(var_template_slug.dup().is_string())) {
		var_routes.array_push('/wp/v2/templates/lookup?slug=' + (var_template_slug).str())
	} else {
		var_routes.array_push("/wp/v2/${var_email_post_type.to_string()}?context=edit&per_page=30&status=publish,sent")
	}
	mut var_preload_data := rt.call_function('array_reduce', [var_routes.dup(), rt.new_string('rest_preload_api_request'), rt.new_array()])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'), rt.call_function('sprintf', [rt.new_string('wp.apiFetch.use( wp.apiFetch.createPreloadingMiddleware( %s ) );'), rt.call_function('wp_json_encode', [var_preload_data.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])])
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_assets_manager(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
		settings_controller: rt.new_null()
		theme_controller: rt.new_null()
		user_theme: rt.new_null()
		assets_path: rt.new_string('')
		assets_url: rt.new_string('')
		logger: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_wp_block_editor_context() &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Logger_Email_Editor_Logger](if args.len > 3 { args[3] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3)
			return rt.new_null()
		}
		'set_assets_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_assets_path(dispatch_arg_0)
			return rt.new_null()
		}
		'set_assets_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_assets_url(dispatch_arg_0)
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'enqueue_admin_styles' {
			this.enqueue_admin_styles()
			return rt.new_null()
		}
		'render_email_editor_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.render_email_editor_html(dispatch_arg_0)
			return rt.new_null()
		}
		'load_editor_assets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.load_editor_assets(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'preload_rest_api_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.preload_rest_api_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'settings_controller' { return this.settings_controller }
		'theme_controller' { return this.theme_controller }
		'user_theme' { return this.user_theme }
		'assets_path' { return this.assets_path }
		'assets_url' { return this.assets_url }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Assets_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'settings_controller' { this.settings_controller = val; return true }
		'theme_controller' { this.theme_controller = val; return true }
		'user_theme' { this.user_theme = val; return true }
		'assets_path' { this.assets_path = val; return true }
		'assets_url' { this.assets_url = val; return true }
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Editor_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_class_assets_manager_php() {
	// unsupported statement: Stmt_Declare
}
