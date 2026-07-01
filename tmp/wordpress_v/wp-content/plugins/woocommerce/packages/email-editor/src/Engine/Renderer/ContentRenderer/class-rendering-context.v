import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	rt.PhpObjectBase
pub mut:
		theme_json rt.PhpVal = rt.new_null()
		email_context rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) construct(mut var_theme_json Class_WP_Theme_JSON, mut var_email_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array)  {
	this.theme_json = var_theme_json.dup()
	this.email_context = var_email_context.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_theme_json() rt.PhpVal {
	return this.theme_json
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_theme_styles() rt.PhpVal {
	mut var_theme := this.get_theme_json()
	return if !(rt.call_method(var_theme, 'get_data', []rt.PhpVal{}).array_get('styles')).is_null() { rt.call_method(var_theme, 'get_data', []rt.PhpVal{}).array_get('styles') } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_theme_settings() rt.PhpVal {
	return rt.call_method(this.get_theme_json(), 'get_settings', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_layout_width_without_padding() string {
	mut var_styles := this.get_theme_styles()
	mut var_layout_settings := if !(this.get_theme_settings().array_get('layout')).is_null() { this.get_theme_settings().array_get('layout') } else { rt.new_array() }
	mut var_width := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}; return temp.parse_value(arg_0) }(if !(var_layout_settings.array_get('contentSize')).is_null() { var_layout_settings.array_get('contentSize') } else { rt.new_string('0px') })
	mut var_padding := if !(var_styles.array_get('spacing').array_get('padding')).is_null() { var_styles.array_get('spacing').array_get('padding') } else { rt.new_array() }
	// unsupported expression: Expr_AssignOp_Minus
	// unsupported expression: Expr_AssignOp_Minus
	return "${var_width.to_string()}px"
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) translate_slug_to_color(color_slug string) string {
	mut var_settings := this.get_theme_settings()
	mut var_color_definitions := rt.call_function('array_merge', [if !(var_settings.array_get('color').array_get('palette').array_get('theme')).is_null() { var_settings.array_get('color').array_get('palette').array_get('theme') } else { rt.new_array() }, if !(var_settings.array_get('color').array_get('palette').array_get('default')).is_null() { var_settings.array_get('color').array_get('palette').array_get('default') } else { rt.new_array() }])
	{
		mut iter_1 := var_color_definitions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_color_definition := item_1.val
			if rt.is_true(rt.identical(var_color_definition.array_get('slug'), rt.new_string(color_slug))) {
				return var_color_definition.array_get('color').to_string().to_lower()
			}
		}
	}
	return color_slug
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_email_context() rt.PhpVal {
	return this.email_context
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_user_id() i64 {
	return (if rt.is_true(rt.new_bool(this.email_context.array_isset(rt.new_string('user_id')) && rt.is_true(rt.new_bool(this.email_context.array_get('user_id').is_long() || this.email_context.array_get('user_id').is_double())))) { // unsupported expression: Expr_Cast_Int } else { rt.new_null() }).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get_recipient_email() string {
	return (if rt.is_true(rt.new_bool(this.email_context.array_isset(rt.new_string('recipient_email')) && rt.is_true(rt.new_bool(this.email_context.array_get('recipient_email').is_string())))) { this.email_context.array_get('recipient_email') } else { rt.new_null() }).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) get(key string, var_default_value rt.PhpVal) rt.PhpVal {
	return if !(this.email_context.array_get(key)).is_null() { this.email_context.array_get(key) } else { var_default_value }
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_rendering_context(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context{
		PhpObjectBase: rt.PhpObjectBase{}
		theme_json: rt.new_null()
		email_context: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Theme_JSON](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_theme_json' {
			return this.get_theme_json()
		}
		'get_theme_styles' {
			return this.get_theme_styles()
		}
		'get_theme_settings' {
			return this.get_theme_settings()
		}
		'get_layout_width_without_padding' {
			return rt.new_string(this.get_layout_width_without_padding())
		}
		'translate_slug_to_color' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.translate_slug_to_color(dispatch_arg_0))
		}
		'get_email_context' {
			return this.get_email_context()
		}
		'get_user_id' {
			return rt.new_int(this.get_user_id())
		}
		'get_recipient_email' {
			return rt.new_string(this.get_recipient_email())
		}
		'get' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_json' { return this.theme_json }
		'email_context' { return this.email_context }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_json' { this.theme_json = val; return true }
		'email_context' { this.email_context = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_class_rendering_context_php() {
	// unsupported statement: Stmt_Declare
}
