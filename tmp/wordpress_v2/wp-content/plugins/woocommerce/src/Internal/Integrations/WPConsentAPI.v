import rt

struct Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_internal_integrations_wpconsentapi() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_Integrations_WPConsentAPI',
		'consent_category', rt.new_string('marketing'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) register() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.on_init()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.new_closure(closure_1_fn),
		rt.new_int(20)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) on_init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_wp_consent_api_active())))) {
		return
	}
	mut var_plugin := rt.call_function('plugin_basename', [
		rt.get_constant('WC_PLUGIN_FILE'),
	])
	rt.call_function('add_filter', [
		rt.new_string('wp_consent_api_registered_${var_plugin.to_string()}'),
		rt.new_string('__return_true'),
	])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.enqueue_consent_api_scripts()
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.new_closure(closure_2_fn)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	rt.call_function('add_filter', [rt.new_string('wc_order_attribution_allow_tracking'),
		rt.new_closure(closure_3_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) is_wp_consent_api_active() rt.PhpVal {
	return rt.call_function('class_exists', [Class_WP_CONSENT_API.class()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) enqueue_consent_api_scripts() {
	mut iife_temp_3 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_3 := iife_temp_3.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-consent-api-integration'),
		rt.call_function('plugins_url', [
			rt.concat(rt.concat(rt.new_string('assets/js/frontend/wp-consent-api-integration'),
				this.get_script_suffix()), rt.new_string('.js')),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'wp-consent-api' },
			rt.ArrayItem{ key: none, val: 'wc-order-attribution' },
		]),
		iife_result_3, rt.new_bool(true)])
	rt.call_function('wp_add_inline_script', [
		rt.new_string('wp-consent-api-integration'),
		rt.call_function('sprintf', [
			rt.new_string('window.wc_order_attribution.params.consentCategory = %s;'),
			rt.call_function('wp_json_encode', [
				rt.get_static_prop('Automattic_WooCommerce_Internal_Integrations_WPConsentAPI',
					'consent_category'),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			]),
		]),
		rt.new_string('before'),
	])
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_integrations_wpconsentapi(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI {
	mut obj := &Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI{
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

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'is_wp_consent_api_active' {
			return this.is_wp_consent_api_active()
		}
		'enqueue_consent_api_scripts' {
			this.enqueue_consent_api_scripts()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
