import rt

pub fn Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller.default_settings() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'enableCustomUnits', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'px' },
			rt.ArrayItem{ key: none, val: '%' },
		]) },
	])
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller {
	rt.PhpObjectBase
pub mut:
	theme_controller             rt.PhpVal = rt.new_null()
	allowed_iframe_style_handles rt.PhpVal = rt.new_array()
	iframe_assets                rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) construct(mut var_theme_controller Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller) {
	this.theme_controller = var_theme_controller
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_settings() rt.PhpVal {
	this.init_iframe_assets()
	mut var_core_default_settings := rt.call_function('get_default_block_editor_settings',
		[]rt.PhpVal{})
	mut var_theme_settings := rt.call_method(this.theme_controller, 'get_settings', []rt.PhpVal{})
	mut var_settings := rt.call_function('array_merge', [var_core_default_settings.clone(),
		Class_Automattic_WooCommerce_EmailEditor_Engine_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller.default_settings()])
	var_settings.array_set('__unstableResolvedAssets', this.iframe_assets)
	var_settings.array_set('allowedIframeStyleHandles', this.allowed_iframe_style_handles)
	mut var_editor_content_styles := rt.call_function('file_get_contents', [
		rt.new_string(@DIR + '/content-editor.css'),
	])
	mut var_shares_content_styles := rt.call_function('file_get_contents', [
		rt.new_string(@DIR + '/content-shared.css'),
	])
	var_settings.array_set('styles', rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'css', val: var_editor_content_styles },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'css', val: var_shares_content_styles },
		]) },
	]))
	var_settings.array_set('autosaveInterval', 60)
	var_settings.array_set('codeEditingEnabled', false)
	var_settings.array_set('__experimentalFeatures', var_theme_settings.clone())
	var_settings.array_set('supportsLayout', true)
	var_settings.array_set('alignWide', true)
	var_settings.array_set('__unstableIsBlockBasedTheme', false)
	return var_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_layout() rt.PhpVal {
	mut var_layout_settings := rt.call_method(this.theme_controller, 'get_layout_settings',
		[]rt.PhpVal{})
	mut var_layout := rt.create_array([
		rt.ArrayItem{
			key: 'contentSize'
			val: var_layout_settings.array_get(rt.new_string('contentSize'))
		},
	])
	if var_layout_settings.array_isset(rt.new_string('wideSize')) {
		var_layout.array_set('wideSize', var_layout_settings.array_get(rt.new_string('wideSize')))
	}
	return var_layout.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_email_styles() rt.PhpVal {
	mut var_theme := this.get_theme()
	return rt.call_method(var_theme, 'get_data', []rt.PhpVal{}).array_get(rt.new_string('styles'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_layout_width_without_padding() string {
	mut var_styles := this.get_email_styles()
	mut var_layout := this.get_layout()
	mut var_width :=
		rt.new_float(this.parse_number_from_string_with_pixels((var_layout.array_get(rt.new_string('contentSize'))).str()))
	var_width = rt.sub(var_width,
		this.parse_number_from_string_with_pixels((var_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')).array_get(rt.new_string('left'))).str()))
	var_width = rt.sub(var_width,
		this.parse_number_from_string_with_pixels((var_styles.array_get(rt.new_string('spacing')).array_get(rt.new_string('padding')).array_get(rt.new_string('right'))).str()))
	return '${var_width.to_string()}px'
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) parse_styles_to_array(styles string) rt.PhpVal {
	mut styles_mutated := styles
	styles_mutated = (rt.call_function('explode', [rt.new_string(';'),
		rt.new_string(styles_mutated).clone()])).str()
	mut var_parsed_styles := rt.new_array()
	mut iter_1 := rt.new_string(styles_mutated).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_style := item_1.val
		var_style = rt.call_function('explode', [rt.new_string(':'),
			var_style.clone()])
		if var_style.clone().array_count() == 2 {
			var_parsed_styles.array_set(var_style.array_get(rt.new_int(0)).to_string().trim_space(),
				var_style.array_get(rt.new_int(1)).to_string().trim_space())
		}
	}
	return var_parsed_styles.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) parse_number_from_string_with_pixels(value string) f64 {
	return rt.new_float((rt.call_function('str_replace', [rt.new_string('px'),
		rt.new_string(''), rt.new_string(value)])).to_f64())
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_theme() rt.PhpVal {
	return rt.call_method(this.theme_controller, 'get_theme', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) translate_slug_to_font_size(font_size string) string {
	return (rt.call_method(this.theme_controller, 'translate_slug_to_font_size', [
		rt.new_string(font_size),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) translate_slug_to_color(color_slug string) string {
	return (rt.call_method(this.theme_controller, 'translate_slug_to_color', [
		rt.new_string(color_slug),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) get_allowed_iframe_style_handles() rt.PhpVal {
	mut var_allowed_iframe_style_handles := rt.create_array([
		rt.ArrayItem{ key: none, val: 'wp-components-css' },
		rt.ArrayItem{ key: none, val: 'wp-reset-editor-styles-css' },
		rt.ArrayItem{ key: none, val: 'wp-block-library-css' },
		rt.ArrayItem{ key: none, val: 'wp-block-editor-content-css' },
		rt.ArrayItem{ key: none, val: 'wp-edit-blocks-css' },
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut iter_2 := rt.call_method(iife_result_0, 'get_all_registered', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block := item_2.val
		if !(rt.get_property(var_block, 'supports').array_isset(rt.new_string('email')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_block, 'supports').array_get(rt.new_string('email')))))) {
			continue
		}
		mut iter_3 := rt.get_property(var_block, 'style_handles').iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_handle := item_3.val
			var_allowed_iframe_style_handles.array_push(var_handle.str() + '-css')
		}
		mut iter_4 := rt.get_property(var_block, 'editor_style_handles').iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_handle := item_4.val
			var_allowed_iframe_style_handles.array_push(var_handle.str() + '-css')
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_allowed_iframe_style_handles'),
		var_allowed_iframe_style_handles.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) init_iframe_assets() {
	if !(!rt.is_true(this.iframe_assets)) {
		return
	}
	this.iframe_assets = rt.call_function('_wp_get_iframed_editor_assets', []rt.PhpVal{})
	this.allowed_iframe_style_handles = this.get_allowed_iframe_style_handles()
	mut var_cleaned_styles := rt.new_array()
	mut iter_5 := rt.call_function('explode', [rt.new_string('\n'),
		rt.new_string((this.iframe_assets.array_get(rt.new_string('styles'))).str())]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_asset := item_5.val
		mut iter_6 := this.allowed_iframe_style_handles.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_handle := item_6.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
				var_asset.clone(),
				var_handle.clone(),
			]), rt.new_bool(false)))))
			{
				var_cleaned_styles.array_push(var_asset.clone())
				break
			}
		}
	}
	this.iframe_assets.array_set('styles', rt.call_function('implode', [
		rt.new_string('\n'),
		var_cleaned_styles.clone(),
	]))
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_settings_controller(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller{
		PhpObjectBase:                rt.PhpObjectBase{}
		theme_controller:             rt.new_null()
		allowed_iframe_style_handles: rt.new_array()
		iframe_assets:                rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_wp_block_type_registry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Theme_Controller](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_settings' {
			return this.get_settings()
		}
		'get_layout' {
			return this.get_layout()
		}
		'get_email_styles' {
			return this.get_email_styles()
		}
		'get_layout_width_without_padding' {
			return rt.new_string(this.get_layout_width_without_padding())
		}
		'parse_styles_to_array' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse_styles_to_array(dispatch_arg_0)
		}
		'parse_number_from_string_with_pixels' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_float(this.parse_number_from_string_with_pixels(dispatch_arg_0))
		}
		'get_theme' {
			return this.get_theme()
		}
		'translate_slug_to_font_size' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.translate_slug_to_font_size(dispatch_arg_0))
		}
		'translate_slug_to_color' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.translate_slug_to_color(dispatch_arg_0))
		}
		'get_allowed_iframe_style_handles' {
			return this.get_allowed_iframe_style_handles()
		}
		'init_iframe_assets' {
			this.init_iframe_assets()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_controller' { return this.theme_controller }
		'allowed_iframe_style_handles' { return this.allowed_iframe_style_handles }
		'iframe_assets' { return this.iframe_assets }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Settings_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_controller' {
			this.theme_controller = val
			return true
		}
		'allowed_iframe_style_handles' {
			this.allowed_iframe_style_handles = val
			return true
		}
		'iframe_assets' {
			this.iframe_assets = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
