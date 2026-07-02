import rt

pub fn Class_Automattic_WooCommerce_Blocks_DependencyDetection.tracked_blocks() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce/checkout' },
		rt.ArrayItem{ key: none, val: 'woocommerce/cart' }, rt.ArrayItem{
			key: none
			val: 'woocommerce/mini-cart'
		}])
}

pub fn Class_Automattic_WooCommerce_Blocks_DependencyDetection.wc_global_exports() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'wcBlocksRegistry', val: 'wc-blocks-registry' },
		rt.ArrayItem{ key: 'wcSettings', val: 'wc-settings' },
		rt.ArrayItem{ key: 'wcBlocksData', val: 'wc-blocks-data-store' },
		rt.ArrayItem{ key: 'data', val: 'wc-store-data' },
		rt.ArrayItem{ key: 'wcBlocksSharedContext', val: 'wc-blocks-shared-context' },
		rt.ArrayItem{ key: 'wcBlocksSharedHocs', val: 'wc-blocks-shared-hocs' },
		rt.ArrayItem{ key: 'priceFormat', val: 'wc-price-format' },
		rt.ArrayItem{ key: 'blocksCheckout', val: 'wc-blocks-checkout' },
		rt.ArrayItem{ key: 'blocksCheckoutEvents', val: 'wc-blocks-checkout-events' },
		rt.ArrayItem{ key: 'blocksComponents', val: 'wc-blocks-components' },
		rt.ArrayItem{ key: 'wcTypes', val: 'wc-types' },
		rt.ArrayItem{ key: 'sanitize', val: 'wc-sanitize' },
	])
}

struct Class_Automattic_WooCommerce_Blocks_DependencyDetection {
	rt.PhpObjectBase
pub mut:
	proxy_output bool
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) construct() {
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DEBUG'))))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_DependencyDetection',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_early_proxy_setup' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_DependencyDetection',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_early_proxy_setup' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_DependencyDetection',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_script_registry' },
		]),
		rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_DependencyDetection',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_script_registry' },
		]),
		rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) output_early_proxy_setup() {
	if !(this.page_has_tracked_blocks()) {
		return
	}
	mut var_script_path := rt.new_string(@DIR +
		'/../../assets/client/blocks/dependency-detection.js')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_script_path.clone()])))))
	{
		return
	}
	mut var_script_content := rt.call_function('file_get_contents', [
		var_script_path.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_script_content)))) {
		return
	}
	mut var_mapping_json := rt.call_function('wp_json_encode', [
		Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_DependencyDetection.wc_global_exports(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_mapping_json)) {
		return
	}
	var_script_content = rt.call_function('str_replace', [
		rt.new_string('__WC_GLOBAL_EXPORTS_PLACEHOLDER__'),
		var_mapping_json.clone(),
		var_script_content.clone(),
	])
	mut var_wc_plugin_url := rt.call_function('plugins_url', [
		rt.new_string('/'), rt.get_constant('WC_PLUGIN_FILE')])
	var_script_content = rt.call_function('str_replace', [
		rt.new_string('__WC_PLUGIN_URL_PLACEHOLDER__'),
		rt.new_string('"' + (rt.call_function('esc_js', [var_wc_plugin_url.clone()])).str() + '"'),
		var_script_content.clone(),
	])
	print('<script id="wc-dependency-detection">' + var_script_content.str() + '</script>' + '\n')
	this.proxy_output = true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) output_script_registry() {
	if !(this.proxy_output) {
		return
	}
	mut var_script_registry := this.build_script_registry()
	mut var_registry_json := rt.call_function('wp_json_encode', [
		var_script_registry.clone()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_registry_json)) {
		return
	}
	print(
		'<script id="wc-dependency-detection-registry">if(typeof window.wc.wcUpdateDependencyRegistry==="function"){window.wc.wcUpdateDependencyRegistry(' +
		var_registry_json.str() + ');}</script>' + '\n')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) build_script_registry() rt.PhpVal {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_registry := rt.new_array()
	mut iter_1 := rt.get_property(var_wp_scripts, 'registered').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_script := item_1.val
		mut var_handle := item_1.key
		if !rt.is_true(rt.get_property(var_script, 'src')) {
			continue
		}
		mut var_src := rt.get_property(var_script, 'src')
		if !(var_src.clone().is_string()) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('|^(https?:)?//|'),
			var_src.clone(),
		])))))
		{
			var_src = rt.new_string((rt.get_property(var_wp_scripts, 'base_url')).str() +
				var_src.str())
		}
		if this.is_woocommerce_script(var_src.str()) {
			continue
		}
		if this.is_wordpress_core_script(var_src.str()) {
			continue
		}
		var_src = rt.new_string(this.normalize_url(var_src.str()))
		var_registry.array_set(var_src, rt.create_array([
			rt.ArrayItem{ key: 'handle', val: var_handle },
			rt.ArrayItem{ key: 'deps', val: this.get_all_dependencies(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](rt.get_property(var_script,
				'deps'))) },
		]))
	}
	return var_registry.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) is_woocommerce_script(url string) bool {
	mut var_wc_plugin_url := rt.call_function('plugins_url', [
		rt.new_string('/'), rt.get_constant('WC_PLUGIN_FILE')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		rt.new_string(url),
		var_wc_plugin_url.clone(),
	]), rt.new_int(0)))))
	{
		return false
	}
	mut var_relative_path := rt.call_function('substr', [rt.new_string(url),
		rt.new_int(var_wc_plugin_url.clone().to_string().len)])
	return (rt.call_function('preg_match', [
		rt.new_string('#^(client|assets|build|vendor)/#'),
		var_relative_path.clone(),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) is_wordpress_core_script(url string) bool {
	return (rt.call_function('preg_match', [rt.new_string('#/(wp-includes|wp-admin)/#'),
		rt.new_string(url)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) get_all_dependencies(mut var_deps Class_Automattic_WooCommerce_Blocks_array) rt.PhpVal {
	mut var_wp_scripts := rt.call_function('wp_scripts', []rt.PhpVal{})
	mut var_all_deps := rt.new_array()
	mut var_deps_to_process := var_deps
	for !(!rt.is_true(var_deps_to_process)) {
		mut var_handle := rt.call_function('array_shift', [var_deps_to_process.clone()])
		if rt.is_true(rt.call_function('in_array', [var_handle.clone(),
			var_all_deps.clone(), rt.new_bool(true)]))
		{
			continue
		}
		var_all_deps.array_push(var_handle.clone())
		if rt.get_property(var_wp_scripts, 'registered').array_isset(var_handle) {
			mut iter_2 := rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle),
				'deps').iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_nested_dep := item_2.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					var_nested_dep.clone(),
					var_all_deps.clone(),
					rt.new_bool(true),
				])))))
				{
					var_deps_to_process.array_push(var_nested_dep.clone())
				}
			}
		}
	}
	mut var_wc_handles := rt.call_function('array_values', [
		Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_DependencyDetection.wc_global_exports(),
	])
	closure_1_fn := fn [var_wc_handles] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dep := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [var_dep.clone(),
			var_wc_handles.clone(), rt.new_bool(true)])
	}
	closure_2_fn := fn [var_wc_handles] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dep := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_function('in_array', [var_dep.clone(),
			var_wc_handles.clone(), rt.new_bool(true)])
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_all_deps.clone(),
			rt.new_closure(closure_1_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) page_has_tracked_blocks() bool {
	mut iter_3 :=
		Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_DependencyDetection.tracked_blocks().iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block_name := item_3.val
		if rt.is_true(rt.call_function('has_block', [var_block_name.clone()])) {
			return true
		}
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil{}
	mut iife_result_2 :=
		iife_temp_2.get_blocks_from_widget_area(rt.new_string('woocommerce/mini-cart'))
	mut var_mini_cart_in_widgets := iife_result_2
	if !(!rt.is_true(var_mini_cart_in_widgets)) {
		return true
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil{}
	mut iife_result_3 := iife_temp_3.get_block_from_template_part(rt.new_string('woocommerce/mini-cart'),
		rt.new_string('header'))
	mut var_mini_cart_in_header := iife_result_3
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(!rt.is_true(var_mini_cart_in_header)) {
		return true
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Blocks_Throwable') {
		mut var_e := var_e_1.clone()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) normalize_url(url string) string {
	mut var_scheme := rt.call_function('wp_parse_url', [rt.new_string(url),
		rt.get_constant('PHP_URL_SCHEME')])
	mut var_host := rt.call_function('wp_parse_url', [rt.new_string(url),
		rt.get_constant('PHP_URL_HOST')])
	mut var_path := rt.call_function('wp_parse_url', [rt.new_string(url),
		rt.get_constant('PHP_URL_PATH')])
	if rt.is_true(var_scheme) && rt.is_true(var_host) && rt.is_true(var_path) {
		mut var_port := rt.call_function('wp_parse_url', [rt.new_string(url),
			rt.get_constant('PHP_URL_PORT')])
		return var_scheme.str() + '://' + var_host.str() + if rt.is_true(var_port) {
			':' + var_port.str()
		} else {
			''
		} + var_path.str()
	}
	return url
}

struct Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_dependencydetection() &Class_Automattic_WooCommerce_Blocks_DependencyDetection {
	mut obj := &Class_Automattic_WooCommerce_Blocks_DependencyDetection{
		PhpObjectBase: rt.PhpObjectBase{}
		proxy_output:  false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_utilities_blocksutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'output_early_proxy_setup' {
			this.output_early_proxy_setup()
			return rt.new_null()
		}
		'output_script_registry' {
			this.output_script_registry()
			return rt.new_null()
		}
		'build_script_registry' {
			return this.build_script_registry()
		}
		'is_woocommerce_script' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_woocommerce_script(dispatch_arg_0))
		}
		'is_wordpress_core_script' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_wordpress_core_script(dispatch_arg_0))
		}
		'get_all_dependencies' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_all_dependencies(mut dispatch_arg_0)
		}
		'page_has_tracked_blocks' {
			return rt.new_bool(this.page_has_tracked_blocks())
		}
		'normalize_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_url(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'proxy_output' { return rt.new_bool(this.proxy_output) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_DependencyDetection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'proxy_output' {
			this.proxy_output = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_BlocksUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
