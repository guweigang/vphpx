import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller {
	rt.PhpObjectBase
pub mut:
		site_theme rt.PhpVal = rt.new_null()
		base_theme_data rt.PhpVal = rt.new_null()
		email_safe_fonts rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) construct()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'initialize' }]), rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) initialize()  {
	rt.call_function('add_action', [rt.new_string('switch_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_site_theme_cache' }])])
	rt.call_function('add_action', [rt.new_string('customize_save_after'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'invalidate_site_theme_cache' }])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_site_styles(mut var_base_theme Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON) rt.PhpVal {
	this.base_theme_data = if rt.is_true(var_base_theme) { var_base_theme.get_data() } else { rt.new_null() }
	mut var_site_theme := this.get_site_theme()
	mut var_site_data := rt.call_method(var_site_theme, 'get_data', []rt.PhpVal{})
	mut var_synced_data := rt.create_array([rt.ArrayItem{ key: 'version', val: 3 }, rt.ArrayItem{ key: 'settings', val: this.sync_settings_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if !(var_site_data.array_get('settings')).is_null() { var_site_data.array_get('settings') } else { rt.new_array() })) }, rt.ArrayItem{ key: 'styles', val: this.sync_styles_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](if !(var_site_data.array_get('styles')).is_null() { var_site_data.array_get('styles') } else { rt.new_array() })) }])
	var_synced_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_synced_site_styles'), var_synced_data.dup(), var_site_data.dup()])
	return var_synced_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_theme(mut var_base_theme Class_Automattic_WooCommerce_EmailEditor_Engine_?WP_Theme_JSON) rt.PhpVal {
	if !(this.is_sync_enabled()) {
		return rt.new_null()
	}
	mut var_synced_data := this.sync_site_styles(mut var_base_theme)
	if !rt.is_true(var_synced_data) || !(var_synced_data.array_isset(rt.new_string('version'))) {
		return rt.new_null()
	}
	return create_wp_theme_json(var_synced_data.dup(), rt.new_string('theme'))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) is_sync_enabled() bool {
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_site_style_sync_enabled'), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) invalidate_site_theme_cache()  {
	if !(this.is_sync_enabled()) {
		return rt.new_null()
	}
	this.site_theme = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_site_theme() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.site_theme)) {
		this.site_theme = create_wp_theme_json()
		rt.call_method(this.site_theme, 'merge', [fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_theme_data() }()])
		rt.call_method(this.site_theme, 'merge', [fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_user_data() }()])
		this.site_theme = rt.call_function('apply_filters', [rt.new_string('woocommerce_email_editor_site_theme'), this.site_theme])
		if rt.call_method(this.site_theme, 'get_raw_data', []rt.PhpVal{}).array_isset(rt.new_string('styles')) {
			this.site_theme = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON{}; return temp.resolve_variables(arg_0) }(this.site_theme)
		}
	}
	return this.site_theme
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_settings_data(mut var_site_settings Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_settings := rt.new_array()
	if var_site_settings.array_get('color').array_isset(rt.new_string('palette')) {
		var_email_settings.array_get_mut('color').array_set('palette', var_site_settings.array_get('color').array_get('palette'))
	}
	return var_email_settings.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) sync_styles_data(mut var_site_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_styles := rt.new_array()
	if !(!rt.is_true(var_site_styles.array_get('color'))) {
		var_email_styles.array_set('color', this.convert_color_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get('color'))))
	}
	if !(!rt.is_true(var_site_styles.array_get('typography'))) {
		var_email_styles.array_set('typography', this.convert_typography_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get('typography')), ''))
	}
	if !(!rt.is_true(var_site_styles.array_get('spacing'))) {
		var_email_styles.array_set('spacing', this.convert_spacing_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get('spacing'))))
	}
	if !(!rt.is_true(var_site_styles.array_get('elements'))) {
		var_email_styles.array_set('elements', this.convert_element_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_site_styles.array_get('elements'))))
	}
	return var_email_styles.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_email_safe_fonts() rt.PhpVal {
	if !rt.is_true(this.email_safe_fonts) {
		mut var_theme_data := rt.cast_array(rt.call_function('json_decode', [// unsupported expression: Expr_Cast_String, rt.new_bool(true)]))
		mut var_font_families := if !(var_theme_data.array_get('settings').array_get('typography').array_get('fontFamilies')).is_null() { var_theme_data.array_get('settings').array_get('typography').array_get('fontFamilies') } else { rt.new_array() }
		if !(!rt.is_true(var_font_families)) {
			{
				mut iter_1 := var_font_families.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_font_family := item_1.val
					this.email_safe_fonts.array_set(var_font_family.array_get('slug').to_string().to_lower(), var_font_family.array_get('fontFamily'))
				}
			}
		}
	}
	return this.email_safe_fonts
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_color_styles(mut var_color_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_colors := rt.new_array()
	this.resolve_and_assign(mut var_color_styles, 'background', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_colors), rt.new_null())
	this.resolve_and_assign(mut var_color_styles, 'text', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_colors), rt.new_null())
	return var_email_colors.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_typography_styles(mut var_typography_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array, element string) rt.PhpVal {
	mut var_email_typography := rt.new_array()
	this.resolve_and_assign(mut var_typography_styles, 'fontFamily', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'convert_to_email_safe_font' }])))
	closure_1_fn := fn [var_element] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_fallback := rt.new_null()
	if var_element.len > 0 && var_element != '0' {
		var_fallback = rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'elements' }, rt.ArrayItem{ key: none, val: rt.new_string(var_element) }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fallback)))) {
		var_fallback = rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]))))
	}
	return rt.new_string(this.convert_to_px_size((var_value).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
	}
	this.resolve_and_assign(mut var_typography_styles, 'fontSize', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_1_fn)))
	mut var_compatible_props := rt.create_array([rt.ArrayItem{ key: none, val: 'fontWeight' }, rt.ArrayItem{ key: none, val: 'fontStyle' }, rt.ArrayItem{ key: none, val: 'lineHeight' }, rt.ArrayItem{ key: none, val: 'letterSpacing' }, rt.ArrayItem{ key: none, val: 'textTransform' }, rt.ArrayItem{ key: none, val: 'textDecoration' }])
	{
		mut iter_1 := var_compatible_props.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prop := item_1.val
			this.resolve_and_assign(mut var_typography_styles, (var_prop).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_typography), rt.new_null())
		}
	}
	return var_email_typography.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_spacing_styles(mut var_spacing_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_spacing := rt.new_array()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return this.convert_spacing_values(var_value.dup(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'padding' }])))
	}
	this.resolve_and_assign(mut var_spacing_styles, 'padding', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_spacing), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_2_fn)))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_fallback := rt.new_string(this.get_base_theme_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](rt.create_array([rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'spacing' }, rt.ArrayItem{ key: none, val: 'blockGap' }]))))
	return rt.new_string(this.convert_to_px_size((var_value).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?string](var_fallback)))
	}
	this.resolve_and_assign(mut var_spacing_styles, 'blockGap', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_email_spacing), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_?callable](rt.new_closure(closure_3_fn)))
	return var_email_spacing.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_element_styles(mut var_element_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
	mut var_email_elements := rt.new_array()
	mut var_supported_elements := rt.create_array([rt.ArrayItem{ key: none, val: 'heading' }, rt.ArrayItem{ key: none, val: 'button' }, rt.ArrayItem{ key: none, val: 'link' }, rt.ArrayItem{ key: none, val: 'h1' }, rt.ArrayItem{ key: none, val: 'h2' }, rt.ArrayItem{ key: none, val: 'h3' }, rt.ArrayItem{ key: none, val: 'h4' }, rt.ArrayItem{ key: none, val: 'h5' }, rt.ArrayItem{ key: none, val: 'h6' }])
	{
		mut iter_1 := var_supported_elements.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			if var_element_styles.array_isset(var_element) {
				var_email_elements.array_set(var_element, this.convert_element_style(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_styles.array_get(var_element)), (var_element).str()))
			}
		}
	}
	return var_email_elements.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_element_style(mut var_element_style Class_Automattic_WooCommerce_EmailEditor_Engine_array, element_name string) rt.PhpVal {
	mut var_email_element := rt.new_array()
	if var_element_style.array_isset(rt.new_string('typography')) {
		var_email_element.array_set('typography', this.convert_typography_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get('typography')), element_name))
	}
	if var_element_style.array_isset(rt.new_string('color')) {
		var_email_element.array_set('color', this.convert_color_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get('color'))))
	}
	if var_element_style.array_isset(rt.new_string('spacing')) {
		var_email_element.array_set('spacing', this.convert_spacing_styles(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_array](var_element_style.array_get('spacing'))))
	}
	return var_email_element.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) resolve_and_assign(mut var_styles Class_Automattic_WooCommerce_EmailEditor_Engine_array, property string, mut var_target Class_Automattic_WooCommerce_EmailEditor_Engine_array, mut var_processor Class_Automattic_WooCommerce_EmailEditor_Engine_?callable) bool {
	mut var_target_mutated := var_target
	if !(var_styles.array_isset(rt.new_string(property))) {
		return false
	}
	mut var_resolved := this.resolve_style_value(var_styles.array_get(property))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_resolved)))) {
		return false
	}
	var_target_mutated.array_set(property, if rt.is_true(var_processor) { rt.call_callable(var_processor, [var_resolved.dup()]) } else { var_resolved })
	return true
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) resolve_style_value(var_style_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_style_value.dup().is_array())) && var_style_value.array_isset(rt.new_string('ref')))) {
		mut var_ref := var_style_value.array_get('ref')
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_ref.dup().is_string()))))) || !rt.is_true(var_ref))) {
			return rt.new_null()
		}
		mut var_path := rt.call_function('explode', [rt.new_string('.'), var_ref.dup()])
		return rt.call_function('_wp_array_get', [rt.call_method(this.get_site_theme(), 'get_data', []rt.PhpVal{}), var_path.dup(), rt.new_null()])
	}
	return var_style_value.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_to_email_safe_font(font_family string) string {
	mut var_email_safe_fonts := this.get_email_safe_fonts()
	mut var_font_map := rt.create_array([rt.ArrayItem{ key: 'helvetica', val: var_email_safe_fonts.array_get('arial') }, rt.ArrayItem{ key: 'times', val: var_email_safe_fonts.array_get('georgia') }, rt.ArrayItem{ key: 'courier', val: var_email_safe_fonts.array_get('courier-new') }, rt.ArrayItem{ key: 'trebuchet', val: var_email_safe_fonts.array_get('trebuchet-ms') }])
	var_email_safe_fonts = rt.call_function('array_merge', [var_email_safe_fonts.dup(), var_font_map.dup()])
	closure_4_fn := fn [var_email_safe_fonts] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_font_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_font_name_lower := rt.new_string(rt.new_string(var_font_name.dup().to_string().to_lower()))
	if var_email_safe_fonts.array_isset(var_font_name_lower) {
		return (var_email_safe_fonts.array_get(var_font_name_lower)).str()
	}
	{
		mut iter_1 := var_email_safe_fonts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_safe_font := item_1.val
			mut var_safe_font_slug := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return (var_safe_font).str()
			}
		}
	}
	return (rt.new_null()).str()
	}
	mut var_get_font_family := rt.new_closure(closure_4_fn)
	mut var_font_family_array := rt.call_function('explode', [rt.new_string(','), rt.new_string(font_family)])
	mut var_first_font := rt.new_string(rt.new_string(var_font_family_array.array_get(0).to_string().trim_space()))
	var_first_font = rt.new_string(rt.new_string(var_first_font.dup().to_string().trim_space()))
	mut var_safe_font_family := rt.call_callable(var_get_font_family, [var_first_font.dup()])
	if rt.is_true(var_safe_font_family) {
		return (var_safe_font_family).str()
	}
	return (.array_get()).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_to_px_size(size string, mut var_fallback Class_Automattic_WooCommerce_EmailEditor_Engine_?string) string {
	mut var_fallback_mutated := var_fallback
	
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) convert_spacing_values(var_spacing_values rt.PhpVal, mut var_base_path Class_Automattic_WooCommerce_EmailEditor_Engine_array) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Site_Style_Sync_Controller) get_base_theme_value(mut var_path Class_Automattic_WooCommerce_EmailEditor_Engine_array) string {
	mut var_path_mutated := var_path
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
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

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_class_site_style_sync_controller_php() {
	// unsupported statement: Stmt_Declare
}
