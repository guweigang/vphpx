import rt

struct Class_WC_Twenty_Eleven {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Eleven.init() {
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'),
		rt.new_string('woocommerce_output_content_wrapper')])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'),
		rt.new_string('woocommerce_output_content_wrapper_end')])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'output_content_wrapper' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_main_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'output_content_wrapper_end' }])])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 150 },
			rt.ArrayItem{ key: 'single_image_width', val: 300 }])])
}

fn Class_WC_Twenty_Eleven.output_content_wrapper() {
	print('<div id="primary"><div id="content" role="main" class="twentyeleven">')
}

fn Class_WC_Twenty_Eleven.output_content_wrapper_end() {
	print('</div></div>')
}

fn create_wc_twenty_eleven(_args ...rt.PhpVal) &Class_WC_Twenty_Eleven {
	mut obj := &Class_WC_Twenty_Eleven{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Twenty_Eleven) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Eleven.init()
			return rt.new_null()
		}
		'output_content_wrapper' {
			Class_WC_Twenty_Eleven.output_content_wrapper()
			return rt.new_null()
		}
		'output_content_wrapper_end' {
			Class_WC_Twenty_Eleven.output_content_wrapper_end()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Twenty_Eleven) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Eleven) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Twenty_Eleven.init()
}
