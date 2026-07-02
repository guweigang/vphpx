import rt

struct Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler {
	rt.PhpObjectBase
pub mut:
	coming_soon_helper rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_internal_comingsoon_comingsoonrequesthandler() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
		'show_coming_soon', rt.new_bool(false))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) init(mut var_coming_soon_helper Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper) {
	this.coming_soon_helper = var_coming_soon_helper
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.call_method(this.coming_soon_helper, 'is_site_live', []rt.PhpVal{})) {
			return
		}
		rt.call_function('add_filter', [rt.new_string('template_include'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'handle_template_include' },
			])])
		rt.call_function('add_filter', [rt.new_string('wp_theme_json_data_theme'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'experimental_filter_theme_json_theme' },
			])])
		rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'enqueue_styles' },
			])])
		rt.call_function('add_action', [rt.new_string('after_setup_theme'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'possibly_init_block_templates' },
			]),
			rt.new_int(999)])
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('plugins_loaded'),
		rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) possibly_init_block_templates() {
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-template-parts')])) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_1 := iife_temp_1.container()
	mut var_container := iife_result_1
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry.class(),
	]), 'init', []rt.PhpVal{})
	rt.call_method(rt.call_method(var_container, 'get', [
		Class_Automattic_WooCommerce_Blocks_BlockTemplatesController.class(),
	]), 'init', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) handle_template_include(var_template rt.PhpVal) string {
	if !(this.should_show_coming_soon()) {
		return var_template.str()
	}
	rt.call_function('header', [rt.new_string('Cache-Control: max-age=60')])
	mut var_is_fse_theme := rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	mut var_is_store_coming_soon := rt.call_method(this.coming_soon_helper, 'is_store_coming_soon',
		[]rt.PhpVal{})
	rt.call_function('add_theme_support', [rt.new_string('block-templates')])
	mut var_coming_soon_template := rt.call_function('get_query_template', [
		rt.new_string('coming-soon'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_fse_theme))))
		&& rt.is_true(var_is_store_coming_soon) {
		rt.call_function('get_header', []rt.PhpVal{})
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		print("<meta name='woo-coming-soon-page' content='yes'>")
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.new_closure(closure_3_fn)])
	if !(!rt.is_true(var_coming_soon_template))
		&& rt.is_true(rt.call_function('file_exists', [var_coming_soon_template.clone()])) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_fse_theme))))
			&& rt.is_true(var_is_store_coming_soon)
			&& rt.is_true(rt.call_function('function_exists', [rt.new_string('get_the_block_template_html')])) {
			rt.echo_val(rt.call_function('get_the_block_template_html', []rt.PhpVal{}))
		} else {
			rt.include_file(var_coming_soon_template.to_string(), '1')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_fse_theme))))
		&& rt.is_true(var_is_store_coming_soon) {
		rt.call_function('get_footer', []rt.PhpVal{})
	}
	if rt.is_true(var_is_fse_theme) {
		return ''
	} else {
		exit(0)
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) should_show_coming_soon() bool {
	if rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
		'show_coming_soon'))
	{
		return true
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_3 := iife_temp_3.is_enabled(rt.new_string('launch-your-store'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
		return false
	}
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	]))
	{
		return false
	}
	if rt.is_true(rt.call_method(this.coming_soon_helper, 'is_store_coming_soon', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_404', []rt.PhpVal{})) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.coming_soon_helper,
		'is_current_page_coming_soon', []rt.PhpVal{})))))
	{
		return false
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coming_soon_exclude'),
		rt.new_bool(false),
	]))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_private_link'),
	]), rt.new_string('yes')))
	{
		if rt.get_superglobal('_GET').array_isset(rt.new_string('woo-share'))
			&& rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_share_key')]), rt.get_superglobal('_GET').array_get(rt.new_string('woo-share')))) {
			rt.call_function('setcookie', [rt.new_string('woo-share'),
				rt.call_function('sanitize_text_field', [
					rt.call_function('wp_unslash', [
						rt.get_superglobal('_GET').array_get(rt.new_string('woo-share')),
					]),
				]),
				rt.add(rt.call_function('time', []rt.PhpVal{}), 60 * 60 * 24 * 90),
				rt.new_string('/')])
			return false
		}
		if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('woo-share'))
			&& rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_share_key')]), rt.get_superglobal('_COOKIE').array_get(rt.new_string('woo-share')))) {
			return false
		}
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler',
		'show_coming_soon', rt.new_bool(true))
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) experimental_filter_theme_json_theme(var_theme_json rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_4 := iife_temp_4.is_enabled(rt.new_string('launch-your-store'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_4)))) {
		return var_theme_json.clone()
	}
	mut var_theme_data := rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
	mut var_font_data := if !(var_theme_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).array_get(rt.new_string('theme'))).is_null() {
		var_theme_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies')).array_get(rt.new_string('theme'))
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'parent',
		[]rt.PhpVal{}))
	{
		mut var_parent_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
			'parent', []rt.PhpVal{})
		mut var_parent_theme_json_file := rt.call_method(var_parent_theme, 'get_file_path', [
			rt.new_string('theme.json'),
		])
		if rt.is_true(rt.call_function('is_readable', [var_parent_theme_json_file.clone()])) {
			mut var_parent_theme_json_data := rt.call_function('json_decode', [
				rt.call_function('file_get_contents', [var_parent_theme_json_file.clone()]),
				rt.new_bool(true),
			])
			if var_parent_theme_json_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontFamilies')) {
				mut var_parent_fonts :=
					var_parent_theme_json_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_get(rt.new_string('fontFamilies'))
				mut iter_1 := var_parent_fonts.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_parent_font := item_1.val
					mut var_found := rt.new_bool(false)
					mut iter_2 := var_font_data.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_existing_font := item_2.val
						if var_parent_font.array_isset(rt.new_string('name'))
							&& var_existing_font.array_isset(rt.new_string('name'))
							&& rt.is_true(rt.identical(var_parent_font.array_get(rt.new_string('name')), var_existing_font.array_get(rt.new_string('name')))) {
							var_found = rt.new_bool(true)
							break
						}
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
						var_font_data.array_push(var_parent_font.clone())
					}
				}
			}
		}
	}
	mut var_fonts_to_add := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'fontFamily', val: '"Inter", sans-serif' },
			rt.ArrayItem{ key: 'name', val: 'Inter' },
			rt.ArrayItem{ key: 'slug', val: 'inter' },
			rt.ArrayItem{ key: 'fontFace', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'fontFamily', val: 'Inter' },
					rt.ArrayItem{ key: 'fontStretch', val: 'normal' },
					rt.ArrayItem{ key: 'fontStyle', val: 'normal' },
					rt.ArrayItem{ key: 'fontWeight', val: '300 900' },
					rt.ArrayItem{ key: 'src', val: rt.create_array([
						rt.ArrayItem{ key: none, val:
							(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
							'/assets/fonts/Inter-VariableFont_slnt,wght.woff2' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'fontFamily', val: 'Cardo' },
			rt.ArrayItem{ key: 'name', val: 'Cardo' },
			rt.ArrayItem{ key: 'slug', val: 'cardo' },
			rt.ArrayItem{ key: 'fontFace', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'fontFamily', val: 'Cardo' },
					rt.ArrayItem{ key: 'fontStyle', val: 'normal' },
					rt.ArrayItem{ key: 'fontWeight', val: '400' },
					rt.ArrayItem{ key: 'src', val: rt.create_array([
						rt.ArrayItem{ key: none, val:
							(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
							'/assets/fonts/cardo_normal_400.woff2' },
					]) },
				]) },
			]) },
		]) },
	])
	mut iter_3 := var_fonts_to_add.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_font_to_add := item_3.val
		mut var_found := rt.new_bool(false)
		mut iter_4 := var_font_data.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_font := item_4.val
			if var_font.array_isset(rt.new_string('name'))
				&& rt.is_true(rt.identical(var_font.array_get(rt.new_string('name')), var_font_to_add.array_get(rt.new_string('name')))) {
				var_found = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
			var_font_data.array_push(var_font_to_add.clone())
		}
	}
	mut var_new_data := rt.create_array([rt.ArrayItem{ key: 'version', val: 1 },
		rt.ArrayItem{ key: 'settings', val: rt.create_array([
			rt.ArrayItem{ key: 'typography', val: rt.create_array([
				rt.ArrayItem{ key: 'fontFamilies', val: rt.create_array([
					rt.ArrayItem{ key: 'theme', val: var_font_data },
				]) },
			]) },
		]) }])
	rt.call_method(var_theme_json, 'update_with', [var_new_data.clone()])
	return var_theme_json.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) enqueue_styles() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_woocommerce'),
	])))))
	{
		return
	}
	mut iife_temp_5 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_5 := iife_temp_5.is_enabled(rt.new_string('launch-your-store'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_5)))) {
		return
	}
	if rt.is_true(rt.call_method(this.coming_soon_helper, 'is_site_live', []rt.PhpVal{})) {
		return
	}
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [rt.new_string('woocommerce-coming-soon'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() +
			'/assets/css/coming-soon' +
			if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { '-rtl' } else { '' } + '.css'),
		rt.new_array(), iife_result_6])
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_comingsoon_comingsoonrequesthandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler{
		PhpObjectBase:      rt.PhpObjectBase{}
		coming_soon_helper: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonHelper](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'possibly_init_block_templates' {
			this.possibly_init_block_templates()
			return rt.new_null()
		}
		'handle_template_include' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.handle_template_include(dispatch_arg_0))
		}
		'should_show_coming_soon' {
			return rt.new_bool(this.should_show_coming_soon())
		}
		'experimental_filter_theme_json_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.experimental_filter_theme_json_theme(dispatch_arg_0)
		}
		'enqueue_styles' {
			this.enqueue_styles()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'coming_soon_helper' { return this.coming_soon_helper }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonRequestHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'coming_soon_helper' {
			this.coming_soon_helper = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
