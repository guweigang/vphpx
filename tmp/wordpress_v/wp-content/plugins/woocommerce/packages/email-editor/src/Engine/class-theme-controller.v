import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller {
	rt.PhpObjectBase
pub mut:
		core_theme rt.PhpVal = rt.new_null()
		base_theme rt.PhpVal = rt.new_null()
		user_theme rt.PhpVal = rt.new_null()
		site_style_sync_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) construct()  {
	this.core_theme = fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_core_data() }()
	this.base_theme = create_wp_theme_json(rt.cast_array(rt.call_function('json_decode', [// unsupported expression: Expr_Cast_String, rt.new_bool(true)])), rt.new_string('default'))
	this.user_theme = create_automattic_woocommerce_emaileditor_engine_user_theme()
	this.site_style_sync_controller = create_automattic_woocommerce_emaileditor_engine_site_style_sync_controller()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_theme() rt.PhpVal {
	mut var_theme := this.get_base_theme()
	rt.call_method(var_theme, 'merge', [rt.call_method(this.user_theme, 'get_theme', []rt.PhpVal{})])
	return var_theme.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_base_theme() rt.PhpVal {
	mut var_theme := create_wp_theme_json()
	rt.call_method(var_theme, 'merge', [this.core_theme])
	rt.call_method(var_theme, 'merge', [this.base_theme])
	if rt.is_true(rt.call_method(this.site_style_sync_controller, 'is_sync_enabled', []rt.PhpVal{})) {
		mut var_site_theme := rt.call_method(this.site_style_sync_controller, 'get_theme', [var_theme.dup()])
		rt.call_method(var_theme, 'merge', [var_site_theme.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_theme_json'), var_theme.dup()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) recursive_replace_presets(var_values rt.PhpVal, var_presets rt.PhpVal) rt.PhpVal {
	mut var_values_mutated := var_values
	mut var_presets_mutated := var_presets
	{
		mut iter_1 := var_values_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				var_values_mutated.array_set(var_key, this.recursive_replace_presets(var_value.dup(), var_presets_mutated.dup()))
			} else if rt.is_true(rt.new_bool(var_value.dup().is_string())) {
				var_values_mutated.array_set(var_key, rt.call_function('preg_replace', [rt.func_array_keys(var_presets_mutated.dup()), rt.call_function('array_values', [var_presets_mutated.dup()]), var_value.dup()]))
			} else {
				var_values_mutated.array_set(var_key, var_value.dup())
			}
		}
	}
	return var_values_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) recursive_extract_preset_variables(var_styles rt.PhpVal) rt.PhpVal {
	mut var_styles_mutated := var_styles
	{
		mut iter_1 := var_styles_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_style_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_style_value.dup().is_array())) {
				var_styles_mutated.array_set(var_key, this.recursive_extract_preset_variables(var_style_value.dup()))
			} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_style_value.dup().is_string())) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.is_preset_reference(arg_0) }(var_style_value.dup())))) {
				var_styles_mutated.array_set(var_key, fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{}; return temp.to_css_var(arg_0) }(var_style_value.dup()))
			} else {
				var_styles_mutated.array_set(var_key, var_style_value.dup())
			}
		}
	}
	return var_styles_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_styles() rt.PhpVal {
	mut var_theme_styles := rt.call_method(this.get_theme(), 'get_data', []rt.PhpVal{}).array_get('styles')
	var_theme_styles = this.recursive_extract_preset_variables(var_theme_styles.dup())
	mut var_variables := this.get_variables_values_map()
	mut var_presets := rt.new_array()
	{
		mut iter_1 := var_variables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_name := item_1.key
			mut var_pattern := rt.new_string('/var\\(' + (rt.call_function('preg_quote', [var_name.dup(), rt.new_string('/')])).str() + '\\)/i')
			var_presets.array_set(var_pattern, var_value.dup())
		}
	}
	return this.recursive_replace_presets(var_theme_styles.dup(), var_presets.dup())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_settings() rt.PhpVal {
	return rt.call_method(this.get_theme(), 'get_settings', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_layout_settings() rt.PhpVal {
	return rt.call_method(this.get_theme(), 'get_settings', []rt.PhpVal{}).array_get('layout')
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_stylesheet_from_context(var_context rt.PhpVal, var_options rt.PhpVal) string {
	return (if rt.is_true(rt.call_function('function_exists', [rt.new_string('gutenberg_style_engine_get_stylesheet_from_context')])) { rt.call_function('gutenberg_style_engine_get_stylesheet_from_context', [var_context.dup(), var_options.dup()]) } else { rt.call_function('wp_style_engine_get_stylesheet_from_context', [var_context.dup(), var_options.dup()]) }).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_stylesheet_for_rendering(mut var_post Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Post, var_template rt.PhpVal) string {
	mut var_email_theme_settings := this.get_settings()
	mut var_css_presets := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_email_theme_settings.array_get('typography').array_get('fontFamilies').array_get('default').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_family := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	{
		mut iter_1 := var_email_theme_settings.array_get('typography').array_get('fontSizes').array_get('default').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_size := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_color_definitions := rt.call_function('array_merge', [if !(var_email_theme_settings.array_get('color').array_get('palette').array_get('theme')).is_null() { var_email_theme_settings.array_get('color').array_get('palette').array_get('theme') } else { rt.new_array() }, if !(var_email_theme_settings.array_get('color').array_get('palette').array_get('default')).is_null() { var_email_theme_settings.array_get('color').array_get('palette').array_get('default') } else { rt.new_array() }])
	{
		mut iter_1 := var_color_definitions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_color := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_css_blocks := rt.new_string(rt.new_string(''))
	mut var_blocks := rt.call_method(this.get_theme(), 'get_styles_block_nodes', []rt.PhpVal{})
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_metadata := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	var_css_blocks = rt.call_function('preg_replace', [rt.new_string('/:root\\s:where\\((.*?)\\)/'), rt.new_string('$1'), var_css_blocks.dup()])
	mut var_elements_styles := if !(rt.call_method(this.get_theme(), 'get_raw_data', []rt.PhpVal{}).array_get('styles').array_get('elements')).is_null() { rt.call_method(this.get_theme(), 'get_raw_data', []rt.PhpVal{}).array_get('styles').array_get('elements') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(var_template) && rt.is_true(rt.get_property(var_template, 'wp_id')))) {
		mut var_template_theme := rt.cast_array(rt.call_function('get_post_meta', [rt.get_property(var_template, 'wp_id'), Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Editor.woocommerce_email_meta_theme_type(), rt.new_bool(true)]))
		mut var_template_styles := rt.cast_array(if !(var_template_theme.array_get('styles')).is_null() { var_template_theme.array_get('styles') } else { rt.new_array() })
		mut var_template_elements := if !(var_template_styles.array_get('elements')).is_null() { var_template_styles.array_get('elements') } else { rt.new_array() }
		var_elements_styles = rt.call_function('array_replace_recursive', [rt.cast_array(var_elements_styles), rt.cast_array(var_template_elements)])
	}
	if rt.is_true(var_post) {
		mut var_post_theme := rt.cast_array(rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('woocommerce_email_theme'), rt.new_bool(true)]))
		mut var_post_styles := rt.cast_array(if !(var_post_theme.array_get('styles')).is_null() { var_post_theme.array_get('styles') } else { rt.new_array() })
		mut var_post_elements := if !(var_post_styles.array_get('elements')).is_null() { var_post_styles.array_get('elements') } else { rt.new_array() }
		var_elements_styles = rt.call_function('array_replace_recursive', [rt.cast_array(var_elements_styles), rt.cast_array(var_post_elements)])
	}
	mut var_css_elements := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_elements_styles.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_elements_style := item_1.val
			mut var_key := item_1.key
			mut var_selector := var_key
			if rt.is_true(rt.identical(rt.new_string('button'), var_key)) {
				var_selector = rt.new_string(rt.new_string('.wp-block-button'))
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported expression: Expr_AssignOp_Concat
				continue
			}
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('heading'))) {
				var_selector = rt.new_string(rt.new_string('h1, h2, h3, h4, h5, h6'))
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('link'))) {
				var_selector = rt.new_string(rt.new_string('a:not(.button-link)'))
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_result := rt.new_string((var_css_presets).str() + (var_css_blocks).str() + (var_css_elements).str())
	mut var_pattern := rt.new_string(rt.new_string('/clamp\\([^,]+,\\s*[^,]+,\\s*([^)]+)\\)/'))
	var_result = // unsupported expression: Expr_Cast_String
	return (var_result).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) translate_slug_to_font_size(font_size string) string {
	mut var_settings := this.get_settings()
	{
		mut iter_1 := var_settings.array_get('typography').array_get('fontSizes').array_get('default').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_size_definition := item_1.val
			if rt.is_true(rt.identical(var_font_size_definition.array_get('slug'), rt.new_string(font_size))) {
				return (var_font_size_definition.array_get('size')).str()
			}
		}
	}
	return font_size
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) translate_slug_to_color(color_slug string) string {
	mut var_settings := this.get_settings()
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

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) get_variables_values_map() rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_variables_css := rt.call_method(this.get_theme(), 'get_stylesheet', [rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }])])
	mut var_map := rt.new_array()
	mut var_pattern := rt.new_string(rt.new_string('/--(.*?):\\s*(.*?);/'))
	if rt.is_true(rt.call_function('preg_match_all', [var_pattern.dup(), var_variables_css.dup(), var_matches.dup(), rt.get_constant('PREG_SET_ORDER')])) {
		{
			mut iter_1 := var_matches.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_match := item_1.val
				var_map.array_set('--' + (.array_get()).str(), var_match.array_get(2))
			}
		}
	}
	return var_map.dup()
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_theme_controller() &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		core_theme: rt.new_null()
		base_theme: rt.new_null()
		user_theme: rt.new_null()
		site_style_sync_controller: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_user_theme() &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_site_style_sync_controller() &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preset_variable_resolver() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_theme' {
			return this.get_theme()
		}
		'get_base_theme' {
			return this.get_base_theme()
		}
		'recursive_replace_presets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.recursive_replace_presets(dispatch_arg_0, dispatch_arg_1)
		}
		'recursive_extract_preset_variables' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.recursive_extract_preset_variables(dispatch_arg_0)
		}
		'get_styles' {
			return this.get_styles()
		}
		'get_settings' {
			return this.get_settings()
		}
		'get_layout_settings' {
			return this.get_layout_settings()
		}
		'get_stylesheet_from_context' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_stylesheet_from_context(dispatch_arg_0, dispatch_arg_1))
		}
		'get_stylesheet_for_rendering' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Post](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_stylesheet_for_rendering(mut dispatch_arg_0, dispatch_arg_1))
		}
		'translate_slug_to_font_size' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.translate_slug_to_font_size(dispatch_arg_0))
		}
		'translate_slug_to_color' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.translate_slug_to_color(dispatch_arg_0))
		}
		'get_variables_values_map' {
			return this.get_variables_values_map()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'core_theme' { return this.core_theme }
		'base_theme' { return this.base_theme }
		'user_theme' { return this.user_theme }
		'site_style_sync_controller' { return this.site_style_sync_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'core_theme' { this.core_theme = val; return true }
		'base_theme' { this.base_theme = val; return true }
		'user_theme' { this.user_theme = val; return true }
		'site_style_sync_controller' { this.site_style_sync_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_User_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_class_theme_controller_php() {
	// unsupported statement: Stmt_Declare
}
