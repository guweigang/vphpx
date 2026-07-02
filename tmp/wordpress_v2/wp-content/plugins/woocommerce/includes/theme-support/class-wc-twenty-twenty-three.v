import rt

struct Class_WC_Twenty_Twenty_Three {
	rt.PhpObjectBase
}

fn Class_WC_Twenty_Twenty_Three.init() {
	rt.call_function('remove_action', [rt.new_string('woocommerce_sidebar'),
		rt.new_string('woocommerce_get_sidebar'), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_enqueue_styles'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'enqueue_styles' }])])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_checkout_before_order_review_heading'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'before_order_review' }]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_checkout_after_order_review'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'after_order_review' }]),
	])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
	rt.call_function('add_theme_support', [rt.new_string('woocommerce'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail_image_width', val: 450 },
			rt.ArrayItem{ key: 'single_image_width', val: 600 }])])
}

fn Class_WC_Twenty_Twenty_Three.enqueue_styles(var_styles rt.PhpVal) rt.PhpVal {
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
			'/assets/css/twenty-twenty-three.css' },
		rt.ArrayItem{ key: 'deps', val: '' },
		rt.ArrayItem{ key: 'version', val: iife_result_0 },
		rt.ArrayItem{ key: 'media', val: 'all' },
		rt.ArrayItem{ key: 'has_rtl', val: true },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_twenty_twenty_three_styles'),
		var_styles_mutated.clone(),
	])
}

fn Class_WC_Twenty_Twenty_Three.before_order_review() {
	print('<div class="col2-set">')
}

fn Class_WC_Twenty_Twenty_Three.after_order_review() {
	print('</div>')
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_twenty_twenty_three(_args ...rt.PhpVal) &Class_WC_Twenty_Twenty_Three {
	mut obj := &Class_WC_Twenty_Twenty_Three{
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

fn (mut this Class_WC_Twenty_Twenty_Three) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Twenty_Twenty_Three.init()
			return rt.new_null()
		}
		'enqueue_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Twenty_Twenty_Three.enqueue_styles(dispatch_arg_0)
		}
		'before_order_review' {
			Class_WC_Twenty_Twenty_Three.before_order_review()
			return rt.new_null()
		}
		'after_order_review' {
			Class_WC_Twenty_Twenty_Three.after_order_review()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Twenty_Twenty_Three) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Twenty_Twenty_Three) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	Class_WC_Twenty_Twenty_Three.init()
}
