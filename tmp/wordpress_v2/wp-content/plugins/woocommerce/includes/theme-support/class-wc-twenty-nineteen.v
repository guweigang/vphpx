import rt

struct Class_WC_Twenty_Nineteen {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Nineteen.init() {
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'),
		rt.new_string('woocommerce_output_content_wrapper'), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'),
		rt.new_string('woocommerce_output_content_wrapper_end'),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'output_content_wrapper' }]),
		rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_main_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'output_content_wrapper_end' }]),
		rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_sidebar'),
		rt.new_string('woocommerce_get_sidebar'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_enqueue_styles'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 300 },
			rt.ArrayItem{ key: 'single_image_width', val: 450 }])])
	rt.call_function('add_action', [rt.new_string('wp'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'tweak_theme_features' }])])
	rt.call_function('add_filter', [rt.new_string('twentynineteen_custom_colors_css'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'custom_colors_css' }]),
		rt.new_int(10), rt.new_int(3)])
}

fn Class_WC_Twenty_Nineteen.output_content_wrapper() {
	print('<section id="primary" class="content-area">')
	print('<main id="main" class="site-main">')
}

fn Class_WC_Twenty_Nineteen.output_content_wrapper_end() {
	print('</main>')
	print('</section>')
}

fn Class_WC_Twenty_Nineteen.enqueue_styles(var_styles rt.PhpVal) rt.PhpVal {
	mut var_styles_mutated := var_styles
	var_styles_mutated.array_unset(rt.new_string('woocommerce-general'))
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	var_styles_mutated.array_set('woocommerce-general', rt.create_array([
		rt.ArrayItem{ key: 'src', val:
			(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
			key: none
			val: 'http:'
		}, rt.ArrayItem{ key: none, val: 'https:' }]), rt.new_string(''), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
			'/assets/css/twenty-nineteen.css' },
		rt.ArrayItem{ key: 'deps', val: '' },
		rt.ArrayItem{ key: 'version', val: iife_result_0 },
		rt.ArrayItem{ key: 'media', val: 'all' },
		rt.ArrayItem{ key: 'has_rtl', val: true },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_twenty_nineteen_styles'),
		var_styles_mutated.clone(),
	])
}

fn Class_WC_Twenty_Nineteen.tweak_theme_features() {
	if rt.is_true(rt.call_function('is_woocommerce', []rt.PhpVal{})) {
		rt.call_function('add_filter', [
			rt.new_string('twentynineteen_can_show_post_thumbnail'),
			rt.new_string('__return_false'),
		])
	}
}

fn Class_WC_Twenty_Nineteen.custom_colors_css(var_css rt.PhpVal, var_primary_color rt.PhpVal, var_saturation rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('register_block_type')]))
		&& rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		return var_css.clone()
	}
	mut var_lightness := rt.call_function('absint', [
		rt.call_function('apply_filters', [
			rt.new_string('twentynineteen_custom_colors_lightness'),
			rt.new_int(33),
		]),
	])
	var_lightness = rt.new_string(var_lightness.str() + '%')
	var_css = rt.concat(var_css, rt.new_string(
		'\n\t\t\t.onsale,\n\t\t\t.woocommerce-info,\n\t\t\t.woocommerce-store-notice {\n\t\t\t\tbackground-color: hsl( ' +
		var_primary_color.str() + ', ' + var_saturation.str() + ', ' + var_lightness.str() +
		' );\n\t\t\t}\n\n\t\t\t.woocommerce-tabs ul li.active a {\n\t\t\t\tcolor: hsl( ' +
		var_primary_color.str() + ', ' + var_saturation.str() + ', ' + var_lightness.str() +
		' );\n\t\t\t\tbox-shadow: 0 2px 0 hsl( ' + var_primary_color.str() + ', ' +
		var_saturation.str() + ', ' + var_lightness.str() + ' );\n\t\t\t}\n\t\t'))
	return var_css.clone()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_twenty_nineteen(_args ...rt.PhpVal) &Class_WC_Twenty_Nineteen {
	mut obj := &Class_WC_Twenty_Nineteen{
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

fn (mut this Class_WC_Twenty_Nineteen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Nineteen.init()
			return rt.new_null()
		}
		'output_content_wrapper' {
			Class_WC_Twenty_Nineteen.output_content_wrapper()
			return rt.new_null()
		}
		'output_content_wrapper_end' {
			Class_WC_Twenty_Nineteen.output_content_wrapper_end()
			return rt.new_null()
		}
		'enqueue_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Twenty_Nineteen.enqueue_styles(dispatch_arg_0)
		}
		'tweak_theme_features' {
			Class_WC_Twenty_Nineteen.tweak_theme_features()
			return rt.new_null()
		}
		'custom_colors_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Twenty_Nineteen.custom_colors_css(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Twenty_Nineteen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Nineteen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Twenty_Nineteen.init()
}
