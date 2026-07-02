import rt

struct Class_WC_Twenty_Seventeen {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Seventeen.init() {
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
	rt.call_function('add_filter', [rt.new_string('woocommerce_enqueue_styles'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_filter', [rt.new_string('twentyseventeen_custom_colors_css'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'custom_colors_css' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 250 },
			rt.ArrayItem{ key: 'single_image_width', val: 350 }])])
}

fn Class_WC_Twenty_Seventeen.enqueue_styles(var_styles rt.PhpVal) rt.PhpVal {
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
			'/assets/css/twenty-seventeen.css' },
		rt.ArrayItem{ key: 'deps', val: '' },
		rt.ArrayItem{ key: 'version', val: iife_result_0 },
		rt.ArrayItem{ key: 'media', val: 'all' },
		rt.ArrayItem{ key: 'has_rtl', val: true },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_twenty_seventeen_styles'),
		var_styles_mutated.clone(),
	])
}

fn Class_WC_Twenty_Seventeen.output_content_wrapper() {
	print('<div class="wrap">')
	print('<div id="primary" class="content-area twentyseventeen">')
	print('<main id="main" class="site-main" role="main">')
}

fn Class_WC_Twenty_Seventeen.output_content_wrapper_end() {
	print('</main>')
	print('</div>')
	rt.call_function('get_sidebar', []rt.PhpVal{})
	print('</div>')
}

fn Class_WC_Twenty_Seventeen.custom_colors_css(var_css rt.PhpVal, var_hue rt.PhpVal, var_saturation rt.PhpVal) rt.PhpVal {
	var_css = rt.concat(var_css, rt.new_string(
		'\n\t\t\t.colors-custom .select2-container--default .select2-selection--single {\n\t\t\t\tborder-color: hsl( ' +
		var_hue.str() + ', ' + var_saturation.str() +
		', 73% );\n\t\t\t}\n\t\t\t.colors-custom .select2-container--default .select2-selection__rendered {\n\t\t\t\tcolor: hsl( ' +
		var_hue.str() + ', ' + var_saturation.str() +
		', 40% );\n\t\t\t}\n\t\t\t.colors-custom .select2-container--default .select2-selection--single .select2-selection__arrow b {\n\t\t\t\tborder-color: hsl( ' +
		var_hue.str() + ', ' + var_saturation.str() +
		', 40% ) transparent transparent transparent;\n\t\t\t}\n\t\t\t.colors-custom .select2-container--focus .select2-selection {\n\t\t\t\tborder-color: #000;\n\t\t\t}\n\t\t\t.colors-custom .select2-container--focus .select2-selection--single .select2-selection__arrow b {\n\t\t\t\tborder-color: #000 transparent transparent transparent;\n\t\t\t}\n\t\t\t.colors-custom .select2-container--focus .select2-selection .select2-selection__rendered {\n\t\t\t\tcolor: #000;\n\t\t\t}\n\t\t'))
	return var_css.clone()
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_twenty_seventeen(_args ...rt.PhpVal) &Class_WC_Twenty_Seventeen {
	mut obj := &Class_WC_Twenty_Seventeen{
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

fn (mut this Class_WC_Twenty_Seventeen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Seventeen.init()
			return rt.new_null()
		}
		'enqueue_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Twenty_Seventeen.enqueue_styles(dispatch_arg_0)
		}
		'output_content_wrapper' {
			Class_WC_Twenty_Seventeen.output_content_wrapper()
			return rt.new_null()
		}
		'output_content_wrapper_end' {
			Class_WC_Twenty_Seventeen.output_content_wrapper_end()
			return rt.new_null()
		}
		'custom_colors_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WC_Twenty_Seventeen.custom_colors_css(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Twenty_Seventeen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Seventeen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	Class_WC_Twenty_Seventeen.init()
}
