import rt

struct Class_WC_Twenty_Twelve {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Twelve.init()  {
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'), rt.new_string('woocommerce_output_content_wrapper')])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'), rt.new_string('woocommerce_output_content_wrapper_end')])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output_content_wrapper' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_main_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output_content_wrapper_end' }])])
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'), rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 200 }, rt.ArrayItem{ key: 'single_image_width', val: 300 }])])
}

fn Class_WC_Twenty_Twelve.output_content_wrapper()  {
	print('<div id="primary" class="site-content"><div id="content" role="main" class="twentytwelve">')
}

fn Class_WC_Twenty_Twelve.output_content_wrapper_end()  {
	print('</div></div>')
}

fn Class_WC_Twenty_Twelve.enqueue_styles()  {
	// unsupported statement: Stmt_InlineHTML
}

fn create_wc_twenty_twelve() &Class_WC_Twenty_Twelve {
	mut obj := &Class_WC_Twenty_Twelve{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Twenty_Twelve) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Twelve.init()
			return rt.new_null()
		}
		'output_content_wrapper' {
			Class_WC_Twenty_Twelve.output_content_wrapper()
			return rt.new_null()
		}
		'output_content_wrapper_end' {
			Class_WC_Twenty_Twelve.output_content_wrapper_end()
			return rt.new_null()
		}
		'enqueue_styles' {
			Class_WC_Twenty_Twelve.enqueue_styles()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Twenty_Twelve) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Twelve) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_theme_support_class_wc_twenty_twelve_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	Class_WC_Twenty_Twelve.init()
}
