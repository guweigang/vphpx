import rt

fn wc_smooth_generator() rt.PhpVal {
	mut var_instance := rt.new_null()
	if rt.is_true(rt.new_bool(var_instance.is_null())) {
		var_instance = create_wc_smoothgenerator_plugin(rt.new_string(@FILE))
	}
	return mut var_instance
}

fn load_wc_smooth_generator() {
	wc_smooth_generator()
}

fn wc_smooth_generator_plugin_action_links(var_links rt.PhpVal) rt.PhpVal {
	mut var_action_links := map[string]rt.PhpVal{}
	var_action_links = {
		'settings': '<a href="' +
			(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('tools.php?page=smoothgenerator')])])).str() +
			'" aria-label="' +
			(rt.call_function('esc_attr__', [rt.new_string('View WooCommerce Smooth Generator settings'), rt.new_string('wc-smooth-generator')])).str() +
			'">' +
			(rt.call_function('esc_html__', [rt.new_string('Settings'), rt.new_string('wc-smooth-generator')])).str() +
			'</a>'
	}
	return rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_action_links),
		var_links.clone(),
	])
}

struct Class_WC_SmoothGenerator_Plugin {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_plugin(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Plugin {
	mut obj := &Class_WC_SmoothGenerator_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		Class_WC_SmoothGenerator_Plugin.class(),
	])))))
	{
		rt.include_file(@DIR + '/vendor/autoload.php', '3')
	}
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'),
		rt.new_string('7.4'), rt.new_string('>=')]))
	{
		rt.call_function('add_action', [rt.new_string('plugins_loaded'),
			rt.new_string('load_wc_smooth_generator'), rt.new_int(20)])
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.call_function('class_exists', [
			Class_Automattic_WooCommerce_Utilities_FeaturesUtil.class(),
		]))
		{
			mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
			mut iife_result_1 := iife_temp_1.declare_compatibility(rt.new_string('custom_order_tables'),
				rt.new_string(@FILE), rt.new_bool(true))
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('before_woocommerce_init'),
		rt.new_closure(closure_2_fn)])
	rt.call_function('add_filter', [
		rt.new_string('plugin_action_links_' +
			(rt.call_function('plugin_basename', [rt.new_string(@FILE)])).str()),
		rt.new_string('wc_smooth_generator_plugin_action_links'),
	])
}
