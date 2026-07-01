import rt

struct Class_WC_Twenty_Twenty {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Twenty.init()  {
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'), rt.new_string('woocommerce_output_content_wrapper'), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'), rt.new_string('woocommerce_output_content_wrapper_end'), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_before_main_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output_content_wrapper' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('woocommerce_after_main_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'output_content_wrapper_end' }]), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_sidebar'), rt.new_string('woocommerce_get_sidebar'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_enqueue_styles'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'), rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 450 }, rt.ArrayItem{ key: 'single_image_width', val: 600 }])])
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'set_white_background' }]), rt.new_int(10)])
}

fn Class_WC_Twenty_Twenty.output_content_wrapper()  {
	print('<section id="primary" class="content-area">')
	print('<main id="main" class="site-main">')
}

fn Class_WC_Twenty_Twenty.output_content_wrapper_end()  {
	print('</main>')
	print('</section>')
}

fn Class_WC_Twenty_Twenty.set_white_background()  {
	mut var_background := rt.call_function('sanitize_hex_color_no_hash', [rt.call_function('get_theme_mod', [rt.new_string('background_color')])])
	mut var_background_default := rt.new_string(rt.new_string('f5efe0'))
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_background)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	rt.call_function('set_theme_mod', [rt.new_string('background_color'), rt.new_string('fff')])
}

fn Class_WC_Twenty_Twenty.enqueue_styles(var_styles rt.PhpVal) rt.PhpVal {
	mut var_styles_mutated := var_styles
	var_styles_mutated.array_unset(rt.new_string('woocommerce-general'))
	var_styles_mutated.array_set('woocommerce-general', rt.create_array([rt.ArrayItem{ key: 'src', val: (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'http:' }, rt.ArrayItem{ key: none, val: 'https:' }]), rt.new_string(''), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})])).str() + '/assets/css/twenty-twenty.css' }, rt.ArrayItem{ key: 'deps', val: '' }, rt.ArrayItem{ key: 'version', val: fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_VERSION')) }, rt.ArrayItem{ key: 'media', val: 'all' }, rt.ArrayItem{ key: 'has_rtl', val: true }]))
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_twenty_twenty_styles'), var_styles_mutated.dup()])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_twenty_twenty() &Class_WC_Twenty_Twenty {
	mut obj := &Class_WC_Twenty_Twenty{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Twenty_Twenty) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Twenty.init()
			return rt.new_null()
		}
		'output_content_wrapper' {
			Class_WC_Twenty_Twenty.output_content_wrapper()
			return rt.new_null()
		}
		'output_content_wrapper_end' {
			Class_WC_Twenty_Twenty.output_content_wrapper_end()
			return rt.new_null()
		}
		'set_white_background' {
			Class_WC_Twenty_Twenty.set_white_background()
			return rt.new_null()
		}
		'enqueue_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Twenty_Twenty.enqueue_styles(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Twenty_Twenty) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Twenty) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_theme_support_class_wc_twenty_twenty_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	Class_WC_Twenty_Twenty.init()
}
