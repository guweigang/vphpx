import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics {
	rt.PhpObjectBase
pub mut:
	asset_api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) construct(mut var_asset_api Class_Automattic_WooCommerce_Blocks_Assets_Api) {
	this.asset_api = var_asset_api
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Google_Analytics_Integration'),
		rt.new_bool(false),
	])))))
	{
		return
	}
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_assets' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
		])])
	rt.call_function('add_filter', [rt.new_string('script_loader_tag'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'async_script_loader_tags' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) register_assets() {
	rt.call_method(this.asset_api, 'register_script', [
		rt.new_string('wc-blocks-google-analytics'),
		rt.new_string('assets/client/blocks/wc-blocks-google-analytics.js'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'google-tag-manager' }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) enqueue_scripts() {
	mut var_settings := this.get_google_analytics_settings()
	mut var_prefix := rt.call_function('strstr', [
		rt.new_string(var_settings.array_get(rt.new_string('ga_id')).to_string().to_upper()),
		rt.new_string('-'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_prefix.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'G' },
			rt.ArrayItem{ key: none, val: 'GT' }]),
		rt.new_bool(true)])))))
	{
		return
	}
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_ga_disable_tracking'),
		rt.new_bool(!(rt.is_true(rt.call_function('wc_string_to_bool', [
			var_settings.array_get(rt.new_string('ga_event_tracking_enabled')),
		])))),
	]))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_script_is', [
		rt.new_string('google-tag-manager'),
		rt.new_string('registered'),
	])))))
	{
		rt.call_function('wp_register_script', [rt.new_string('google-tag-manager'),
			rt.new_string('https://www.googletagmanager.com/gtag/js?id=' +
				(var_settings.array_get(rt.new_string('ga_id'))).str()),
			rt.new_array(), rt.new_null(),
			rt.create_array([
				rt.ArrayItem{ key: 'in_footer', val: false },
				rt.ArrayItem{ key: 'strategy', val: 'async' },
			])])
		rt.call_function('wp_add_inline_script', [rt.new_string('google-tag-manager'),
			rt.new_string(
				"\n\twindow.dataLayer = window.dataLayer || [];\n\tfunction gtag(){dataLayer.push(arguments);}\n\tgtag('js', new Date());\n\tgtag('config', '" +
				(rt.call_function('esc_js', [var_settings.array_get(rt.new_string('ga_id'))])).str() +
				"', { 'send_page_view': false });")])
	}
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-blocks-google-analytics')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) get_google_analytics_settings() rt.PhpVal {
	return rt.call_function('wp_parse_args', [
		rt.call_function('get_option', [
			rt.new_string('woocommerce_google_analytics_settings'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'ga_id', val: '' },
			rt.ArrayItem{ key: 'ga_event_tracking_enabled', val: 'no' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) async_script_loader_tags(var_tag rt.PhpVal, var_handle rt.PhpVal, var_src rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_handle.clone(), rt.create_array([
			rt.ArrayItem{ key: none, val: 'google-tag-manager' },
		]),
		rt.new_bool(true)])))))
	{
		return var_tag.str()
	}
	if rt.is_true(rt.call_function('did_action', [
		rt.new_string('woocommerce_gtag_snippet'),
	]))
	{
		return ''
	}
	return (rt.call_function('str_replace', [rt.new_string('<script src'),
		rt.new_string('<script async src'), var_tag.clone()])).str()
}

fn create_automattic_woocommerce_blocks_domain_services_googleanalytics(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics{
		PhpObjectBase: rt.PhpObjectBase{}
		asset_api:     rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_Api](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_assets' {
			this.register_assets()
			return rt.new_null()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'get_google_analytics_settings' {
			return this.get_google_analytics_settings()
		}
		'async_script_loader_tags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.async_script_loader_tags(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'asset_api' { return this.asset_api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_GoogleAnalytics) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'asset_api' {
			this.asset_api = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
