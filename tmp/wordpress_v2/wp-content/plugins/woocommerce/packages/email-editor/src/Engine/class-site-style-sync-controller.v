import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	rt.PhpObjectBase
pub mut:
		site_theme rt.PhpVal = rt.new_null()
		base_theme_data rt.PhpVal = rt.new_null()
		email_safe_fonts rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) construct() {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize' }]), rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) initialize() {
	rt.call_function('add_action', [rt.new_string('switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_site_theme_cache' }])])
	rt.call_function('add_action', [rt.new_string('customize_save_after'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_site_theme_cache' }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_site_styles(mut var_base_theme Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON) rt.PhpVal {
	this.base_theme_data = if rt.is_true(var_base_theme) { var_base_theme.get_data() } else { rt.new_null() }
	mut var_site_theme := this.get_site_theme()
	mut var_site_data := rt.call_method(var_site_theme, 'get_data', []rt.PhpVal{})
	mut var_synced_data := rt.create_array([rt.ArrayItem{ key: 'version', val: 3 }, rt.ArrayItem{ key: 'settings', val: this.sync_settings_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if !(var_site_data.array_get(rt.new_string('settings'))).is_null() { var_site_data.array_get(rt.new_string('settings')) } else { rt.new_array() })) }, rt.ArrayItem{ key: 'styles', val: this.sync_styles_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if !(var_site_data.array_get(rt.new_string('styles'))).is_null() { var_site_data.array_get(rt.new_string('styles')) } else { rt.new_array() })) }])
	var_synced_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_synced_site_styles'), var_synced_data.clone(), var_site_data.clone()])
	return var_synced_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_theme(mut var_base_theme Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON) rt.PhpVal {
	if !(this.is_sync_enabled()) {
		return rt.new_null()
	}
	mut var_synced_data := this.sync_site_styles(mut var_base_theme)
	if !rt.is_true(var_synced_data) || !(var_synced_data.array_isset(rt.new_string('version'))) {
		return rt.new_null()
	}
	return create_wp_theme_json(var_synced_data.clone(), rt.new_string('theme'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) is_sync_enabled() bool {
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_site_style_sync_enabled'), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) invalidate_site_theme_cache() {
	if !(this.is_sync_enabled()) {
		return
	}
	this.site_theme = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_site_theme() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.site_theme)) {
		this.site_theme = create_wp_theme_json()
		mut iife_temp_0 := Class_WP_Theme_JSON_Resolver{}
		mut iife_result_0 := iife_temp_0.get_theme_data()
		rt.call_method(this.site_theme, 'merge', [iife_result_0])
		mut iife_temp_1 := Class_WP_Theme_JSON_Resolver{}
		mut iife_result_1 := iife_temp_1.get_user_data()
		rt.call_method(this.site_theme, 'merge', [iife_result_1])
		this.site_theme = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_site_theme'), this.site_theme])
		if rt.call_method(this.site_theme, 'get_raw_data', []rt.PhpVal{}).array_isset(rt.new_string('styles')) {
			mut iife_temp_2 := Class_WP_Theme_JSON{}
			mut iife_result_2 := iife_temp_2.resolve_variables(this.site_theme)
			this.site_theme = iife_result_2
		}
	}
	return this.site_theme
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_settings_data(mut var_site_settings Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_settings := rt.new_array()
	if var_site_settings.array_get(rt.new_string('color')).array_isset(rt.new_string('palette')) {
		var_email_settings.array_get_mut('color').array_set('palette', var_site_settings.array_get(rt.new_string('color')).array_get(rt.new_string('palette')))
	}
	return var_email_settings.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_styles_data(mut var_site_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_styles := rt.new_array()
	if !(!rt.is_true(var_site_styles.array_get(rt.new_string('color')))) {
		var_email_styles.array_set('color', this.convert_color_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get(rt.new_string('color')))))
	}
	if !(!rt.is_true(var_site_styles.array_get(rt.new_string('typography')))) {
		var_email_styles.array_set('typography', this.convert_typography_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get(rt.new_string('typography'))), ''))
	}
	if !(!rt.is_true(var_site_styles.array_get(rt.new_string('spacing')))) {
		var_email_styles.array_set('spacing', this.convert_spacing_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get(rt.new_string('spacing')))))
	}
	if !(!rt.is_true(var_site_styles.array_get(rt.new_string('elements')))) {
		var_email_styles.array_set('elements', this.convert_element_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get(rt.new_string('elements')))))
	}
	return var_email_styles.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_email_safe_fonts() rt.PhpVal {
	if !rt.is_true(this.email_safe_fonts) {
		mut var_theme_data := rt.cast_array(rt.call_function('json_decode', [rt.new_string((rt.call_function('file_get_contents', [rt.new_string(@DIR + '/theme.json')])).str()), rt.new_bool(true)]))
		mut var_font_families := if !(var_theme_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies'))).is_null() { var_theme_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')) } else { rt.new_array() }
		if !(!rt.is_true(var_font_families)) {
			mut iter_1 := var_font_families.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_font_family := item_1.val
				this.email_safe_fonts.array_set(var_font_family.array_get(rt.new_string('slug')).to_string().to_lower(), var_font_family.array_get(rt.new_string('fontFamily')))
			}
		}
	}
	return this.email_safe_fonts
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_color_styles(mut var_color_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_colors := rt.new_array()
	this.resolve_and_assign(mut var_color_styles, 'background', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_colors), rt.new_null())
	this.resolve_and_assign(mut var_color_styles, 'text', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_colors), rt.new_null())
	return var_email_colors.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_typography_styles(mut var_typography_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array, element string) rt.PhpVal {
	mut var_email_typography := rt.new_array()
	this.resolve_and_assign(mut var_typography_styles, 'fontFamily', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'convert_to_email_safe_font' }])))
	closure_4_fn := fn [var_element] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fallback := rt.new_null()
		if var_element.len > 0 && var_element != '0' {
		var_fallback = rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'elements' }, rt.ArrayItem{ key: none, val: rt.new_string((var_element).str()) }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]))))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_fallback)))) {
		var_fallback = rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]))))
		}
		return rt.new_string(this.convert_to_px_size((var_value).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
		}
	this.resolve_and_assign(mut var_typography_styles, 'fontSize', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_4_fn)))
	mut var_compatible_props := rt.create_array([rt.ArrayItem{ key: none, val: 'fontWeight' }, rt.ArrayItem{ key: none, val: 'fontStyle' }, rt.ArrayItem{ key: none, val: 'lineHeight' }, rt.ArrayItem{ key: none, val: 'letterSpacing' }, rt.ArrayItem{ key: none, val: 'textTransform' }, rt.ArrayItem{ key: none, val: 'textDecoration' }])
	mut iter_2 := var_compatible_props.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_prop := item_2.val
		this.resolve_and_assign(mut var_typography_styles, (var_prop).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), rt.new_null())
	}
	return var_email_typography.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_spacing_styles(mut var_spacing_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_spacing := rt.new_array()
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.convert_spacing_values(var_value.clone(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }])))
		}
	this.resolve_and_assign(mut var_spacing_styles, 'padding', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_spacing), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_5_fn)))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_fallback := rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }]))))
		return rt.new_string(this.convert_to_px_size((var_value).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
		}
	this.resolve_and_assign(mut var_spacing_styles, 'blockGap', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_spacing), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_6_fn)))
	return var_email_spacing.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_element_styles(mut var_element_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_elements := rt.new_array()
	mut var_supported_elements := rt.create_array([rt.ArrayItem{ key: none, val: 'heading' }, rt.ArrayItem{ key: none, val: 'button' }, rt.ArrayItem{ key: none, val: 'link' }, rt.ArrayItem{ key: none, val: 'h1' }, rt.ArrayItem{ key: none, val: 'h2' }, rt.ArrayItem{ key: none, val: 'h3' }, rt.ArrayItem{ key: none, val: 'h4' }, rt.ArrayItem{ key: none, val: 'h5' }, rt.ArrayItem{ key: none, val: 'h6' }])
	mut iter_3 := var_supported_elements.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_element := item_3.val
		if var_element_styles.array_isset(var_element) {
			var_email_elements.array_set(var_element, this.convert_element_style(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_styles.array_get(var_element)), (var_element).str()))
		}
	}
	return var_email_elements.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_element_style(mut var_element_style Class_Automattic_WooCommerce_EmailEditor_Engine_array, element_name string) rt.PhpVal {
	mut var_email_element := rt.new_array()
	if var_element_style.array_isset(rt.new_string('typography')) {
		var_email_element.array_set('typography', this.convert_typography_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get(rt.new_string('typography'))), element_name))
	}
	if var_element_style.array_isset(rt.new_string('color')) {
		var_email_element.array_set('color', this.convert_color_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get(rt.new_string('color')))))
	}
	if var_element_style.array_isset(rt.new_string('spacing')) {
		var_email_element.array_set('spacing', this.convert_spacing_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get(rt.new_string('spacing')))))
	}
	return var_email_element.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) resolve_and_assign(mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array, property string, mut var_target Class_Automattic_WooCommerce_EmailEditor_Engine_array, mut var_processor Class_Automattic_WooCommerce_EmailEditor_Engine_?callable) bool {
	mut var_target_mutated := var_target
	if !(var_styles.array_isset(rt.new_string(property))) {
		return false
	}
	mut var_resolved := this.resolve_style_value(var_styles.array_get(rt.new_string(property)))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_resolved)))) {
		return false
	}
	var_target_mutated.array_set(property, if rt.is_true(var_processor) { rt.call_callable(var_processor, [var_resolved.clone()]) } else { var_resolved })
	return true
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) resolve_style_value(var_style_value rt.PhpVal) rt.PhpVal {
	if var_style_value.clone().is_array() && var_style_value.array_isset(rt.new_string('ref')) {
		mut var_ref := var_style_value.array_get(rt.new_string('ref'))
		if !(var_ref.clone().is_string()) || !rt.is_true(var_ref) {
			return rt.new_null()
		}
		mut var_path := rt.call_function('explode', [rt.new_string('.'), var_ref.clone()])
		return rt.call_function('_wp_array_get', [rt.call_method(this.get_site_theme(), 'get_data', []rt.PhpVal{}), var_path.clone(), rt.new_null()])
	}
	return var_style_value.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_to_email_safe_font(font_family string) string {
	mut var_email_safe_fonts := this.get_email_safe_fonts()
	mut var_font_map := rt.create_array([rt.ArrayItem{ key: 'helvetica', val: var_email_safe_fonts.array_get(rt.new_string('arial')) }, rt.ArrayItem{ key: 'times', val: var_email_safe_fonts.array_get(rt.new_string('georgia')) }, rt.ArrayItem{ key: 'courier', val: var_email_safe_fonts.array_get(rt.new_string('courier-new')) }, rt.ArrayItem{ key: 'trebuchet', val: var_email_safe_fonts.array_get(rt.new_string('trebuchet-ms')) }])
	var_email_safe_fonts = rt.call_function('array_merge', [var_email_safe_fonts.clone(), var_font_map.clone()])
	closure_7_fn := fn [var_email_safe_fonts] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_font_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_font_name_lower := rt.new_string(var_font_name.clone().to_string().to_lower())
		if var_email_safe_fonts.array_isset(var_font_name_lower) {
			return (var_email_safe_fonts.array_get(var_font_name_lower)).str()
		}
		mut iter_4 := var_email_safe_fonts.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_safe_font := item_4.val
			mut var_safe_font_slug := item_4.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [var_safe_font.clone(), var_font_name_lower.clone()]), rt.new_bool(false))))) {
				return (var_safe_font).str()
			}
		}
		return (rt.new_null()).str()
		}
	mut var_get_font_family := rt.new_closure(closure_7_fn)
	mut var_font_family_array := rt.call_function('explode', [rt.new_string(','), rt.new_string(font_family)])
	mut var_first_font := rt.new_string(var_font_family_array.array_get(rt.new_int(0)).to_string().trim_space())
	var_first_font = rt.new_string(var_first_font.clone().to_string().trim_space())
	mut var_safe_font_family := rt.call_callable(var_get_font_family, [var_first_font.clone()])
	if rt.is_true(var_safe_font_family) {
		return (var_safe_font_family).str()
	}
	return (var_email_safe_fonts.array_get(rt.new_string('arial'))).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_to_px_size(size string, mut var_fallback Class_Automattic_WooCommerce_EmailEditor_Engine_?string) string {
	mut var_fallback_mutated := var_fallback
	mut var_converted := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [rt.new_string(size), rt.new_string('clamp(')]), rt.new_bool(false))))) {
		mut iife_temp_7 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
		mut iife_result_7 := iife_temp_7.clamp_to_static_px(rt.new_string(size), rt.new_string('min'))
		var_converted = iife_result_7
		if rt.is_true(rt.identical(var_converted, rt.new_string(size))) {
		var_converted = rt.new_null()
		}
	}
	if rt.is_true(rt.new_bool(var_converted.clone().is_null())) {
	mut iife_temp_8 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_8 := iife_temp_8.convert_to_px(rt.new_string(size), rt.new_bool(false))
	var_converted = iife_result_8
	}
	if var_converted.clone().is_null() && rt.is_true(var_fallback_mutated) {
		return var_fallback_mutated
	}
	return (if !(var_converted).is_null() { var_converted } else { rt.new_string(size) }).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_spacing_values(var_spacing_values rt.PhpVal, mut var_base_path Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	if !(var_spacing_values.clone().is_string()) && !(var_spacing_values.clone().is_array()) {
		return var_spacing_values.clone()
	}
	if rt.is_true(rt.new_bool(var_spacing_values.clone().is_string())) {
		mut var_fallback := rt.new_string(this.get_base_theme_value(mut var_base_path))
		return rt.new_string(this.convert_to_px_size((var_spacing_values).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
	}
	mut var_px_values := rt.new_array()
	mut iter_5 := var_spacing_values.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_value := item_5.val
		mut var_side := item_5.key
		if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
			mut var_side_path := rt.call_function('array_merge', [var_base_path, rt.create_array([rt.ArrayItem{ key: none, val: var_side }])])
			var_fallback = rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_side_path)))
			var_px_values.array_set(var_side, this.convert_to_px_size((var_value).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
		} else {
			var_px_values.array_set(var_side, var_value.clone())
		}
	}
	return var_px_values.clone()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_base_theme_value(mut var_path Class_Automattic_WooCommerce_EmailEditor_Engine_array) string {
	mut var_path_mutated := var_path
	if rt.is_true(rt.new_bool(!(rt.is_true(this.base_theme_data)))) {
		return (rt.new_null()).str()
	}
	mut var_value := rt.call_function('_wp_array_get', [this.base_theme_data, var_path_mutated])
	return (if var_value.clone().is_string() { var_value } else { rt.new_null() }).str()
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_site_style_sync_controller() &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		site_theme: rt.new_null()
		base_theme_data: rt.new_null()
		email_safe_fonts: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'sync_site_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sync_site_styles(mut dispatch_arg_0)
		}
		'get_theme' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_theme(mut dispatch_arg_0)
		}
		'is_sync_enabled' {
			return rt.new_bool(this.is_sync_enabled())
		}
		'invalidate_site_theme_cache' {
			this.invalidate_site_theme_cache()
			return rt.new_null()
		}
		'get_site_theme' {
			return this.get_site_theme()
		}
		'sync_settings_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sync_settings_data(mut dispatch_arg_0)
		}
		'sync_styles_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.sync_styles_data(mut dispatch_arg_0)
		}
		'get_email_safe_fonts' {
			return this.get_email_safe_fonts()
		}
		'convert_color_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convert_color_styles(mut dispatch_arg_0)
		}
		'convert_typography_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.convert_typography_styles(mut dispatch_arg_0, dispatch_arg_1)
		}
		'convert_spacing_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convert_spacing_styles(mut dispatch_arg_0)
		}
		'convert_element_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.convert_element_styles(mut dispatch_arg_0)
		}
		'convert_element_style' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.convert_element_style(mut dispatch_arg_0, dispatch_arg_1)
		}
		'resolve_and_assign' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](if args.len > 3 { args[3] } else { rt.new_null() })
			return rt.new_bool(this.resolve_and_assign(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3))
		}
		'resolve_style_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.resolve_style_value(dispatch_arg_0)
		}
		'convert_to_email_safe_font' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.convert_to_email_safe_font(dispatch_arg_0))
		}
		'convert_to_px_size' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.convert_to_px_size(dispatch_arg_0, mut dispatch_arg_1))
		}
		'convert_spacing_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.convert_spacing_values(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_base_theme_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.get_base_theme_value(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'site_theme' { return this.site_theme }
		'base_theme_data' { return this.base_theme_data }
		'email_safe_fonts' { return this.email_safe_fonts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'site_theme' { this.site_theme = val; return true }
		'base_theme_data' { this.base_theme_data = val; return true }
		'email_safe_fonts' { this.email_safe_fonts = val; return true }
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


fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
