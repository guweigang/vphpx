import rt

struct Class_WC_Twenty_Twenty_One {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Twenty_One.init() {
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'),
		rt.new_string('woocommerce_output_content_wrapper'), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'),
		rt.new_string('woocommerce_output_content_wrapper_end'),
		rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_sidebar'),
		rt.new_string('woocommerce_get_sidebar'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_enqueue_styles'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_admin_styles' }])])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 450 },
			rt.ArrayItem{ key: 'single_image_width', val: 600 }])])
}

fn Class_WC_Twenty_Twenty_One.enqueue_styles(var_styles rt.PhpVal) rt.PhpVal {
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
			'/assets/css/twenty-twenty-one.css' },
		rt.ArrayItem{ key: 'deps', val: '' },
		rt.ArrayItem{ key: 'version', val: iife_result_0 },
		rt.ArrayItem{ key: 'media', val: 'all' },
		rt.ArrayItem{ key: 'has_rtl', val: true },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_twenty_twenty_one_styles'),
		var_styles_mutated.clone(),
	])
}

fn Class_WC_Twenty_Twenty_One.enqueue_admin_styles() {
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_style', [
		rt.new_string('woocommerce-twenty-twenty-one-admin'),
		rt.new_string(
			(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
			key: none
			val: 'http:'
		}, rt.ArrayItem{ key: none, val: 'https:' }]), rt.new_string(''), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() +
			'/assets/css/twenty-twenty-one-admin.css'),
		rt.new_string(''),
		iife_result_1,
		rt.new_string('all'),
	])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_twenty_twenty_one(_args ...rt.PhpVal) &Class_WC_Twenty_Twenty_One {
	mut obj := &Class_WC_Twenty_Twenty_One{
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

fn (mut this Class_WC_Twenty_Twenty_One) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Twenty_One.init()
			return rt.new_null()
		}
		'enqueue_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Twenty_Twenty_One.enqueue_styles(dispatch_arg_0)
		}
		'enqueue_admin_styles' {
			Class_WC_Twenty_Twenty_One.enqueue_admin_styles()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Twenty_Twenty_One) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Twenty_One) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	Class_WC_Twenty_Twenty_One.init()
}
