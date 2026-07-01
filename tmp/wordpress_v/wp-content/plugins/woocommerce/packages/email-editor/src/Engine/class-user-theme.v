import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.user_theme_post_name() string {
	return 'wp-global-styles-woocommerce-email'
}
pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.initial_theme_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'version', val: 3 }, rt.ArrayItem{ key: 'isGlobalStylesUserThemeJSON', val: true }])
}
struct Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	rt.PhpObjectBase
pub mut:
		user_theme_post rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) get_theme() rt.PhpVal {
	mut var_post := this.get_user_theme_post()
	mut var_theme_data := rt.call_function('json_decode', [rt.get_property(var_post, 'post_content'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_theme_data.dup().is_array()))))) {
		var_theme_data = Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.initial_theme_data()
	}
	return create_wp_theme_json(var_theme_data.dup(), rt.new_string('custom'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) get_user_theme_post() rt.PhpVal {
	this.ensure_theme_post()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(this.user_theme_post, 'WP_Post')))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Exception', []string{}, create_automattic_woocommerce_emaileditor_engine_exception(rt.new_string('Error creating user theme post'))))
	}
	return this.user_theme_post
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) ensure_theme_post()  {
	if rt.is_true(this.user_theme_post) {
		return rt.new_null()
	}
	this.user_theme_post = rt.call_function('get_page_by_path', [Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.user_theme_post_name(), rt.get_constant('OBJECT'), rt.new_string('wp_global_styles')])
	if rt.is_true(rt.new_bool(rt.instance_of(this.user_theme_post, 'WP_Post'))) {
		return rt.new_null()
	}
	mut var_post_data := rt.create_array([rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [rt.new_string('Custom Email Styles'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'post_name', val: Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_User_Theme.user_theme_post_name() }, rt.ArrayItem{ key: 'post_content', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_type', val: 'wp_global_styles' }])
	mut var_post_id := rt.call_function('wp_insert_post', [var_post_data.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Exception', []string{}, create_automattic_woocommerce_emaileditor_engine_exception('Error creating user theme post: ' + (rt.call_function('esc_html', [rt.call_method(var_post_id, 'get_error_message', []rt.PhpVal{})])).str())))
	}
	this.user_theme_post = rt.call_function('get_post', [var_post_id.dup()])
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_user_theme() &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
		user_theme_post: rt.new_null()
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_exception() &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_theme' {
			return this.get_theme()
		}
		'get_user_theme_post' {
			return this.get_user_theme_post()
		}
		'ensure_theme_post' {
			this.ensure_theme_post()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user_theme_post' { return this.user_theme_post }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user_theme_post' { this.user_theme_post = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_class_user_theme_php() {
	// unsupported statement: Stmt_Declare
}
