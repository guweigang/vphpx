import rt

struct Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController {
	rt.PhpObjectBase
pub mut:
		consent rt.PhpVal = rt.new_null()
		feature_controller rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
		proxy rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_internal_orders_orderattributioncontroller() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', 'is_stamp_html_called', rt.new_bool(false))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) init(mut var_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy, mut var_controller Class_Automattic_WooCommerce_Internal_Features_FeaturesController, mut var_consent Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI) {
	this.proxy = var_proxy
	this.feature_controller = var_controller
	this.consent = var_consent
	this.logger = var_proxy.call_function(rt.new_string('wc_get_logger'))
	this.set_fields_and_prefix()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) register() {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_INSTALLING'))
	if rt.is_true(iife_result_0) {
		return
	}
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'on_init' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) on_init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.feature_controller, 'feature_is_enabled', [rt.new_string('order_attribution')]))))) {
		return
	}
	rt.set_static_prop('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', 'is_stamp_html_called', rt.new_bool(false))
	rt.call_method(this.consent, 'register', []rt.PhpVal{})
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.enqueue_scripts_and_styles()
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.new_closure(closure_2_fn)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.enqueue_admin_scripts_and_styles()
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.new_closure(closure_3_fn)])
	mut var_stamp_checkout_html_actions := rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_stamp_checkout_html_actions'), rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_checkout_billing' }, rt.ArrayItem{ key: none, val: 'woocommerce_after_checkout_billing_form' }, rt.ArrayItem{ key: none, val: 'woocommerce_checkout_shipping' }, rt.ArrayItem{ key: none, val: 'woocommerce_after_order_notes' }, rt.ArrayItem{ key: none, val: 'woocommerce_checkout_after_customer_details' }])])
	mut iter_1 := var_stamp_checkout_html_actions.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_action := item_1.val
		rt.call_function('add_action', [var_action.clone(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'stamp_html_element' }])])
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_register_form'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this) }, rt.ArrayItem{ key: none, val: 'stamp_html_element' }])])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if this.has_attribution(var_order.clone()) {
			return
		}
		mut var_params := this.get_unprefixed_field_values(rt.get_superglobal('_POST').clone())
		rt.call_function('do_action', [rt.new_string('woocommerce_order_save_attribution_data'), var_order.clone(), var_params.clone()])
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('woocommerce_checkout_order_created'), rt.new_closure(closure_4_fn)])
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_data := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_source_data := this.get_source_values(var_data.clone())
		this.send_order_tracks(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_source_data), mut rt.cast_object_ptr[Class_WC_Order](var_order))
		this.set_order_source_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](var_source_data), mut rt.cast_object_ptr[Class_WC_Order](var_order))
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('woocommerce_order_save_attribution_data'), rt.new_closure(closure_5_fn), rt.new_int(10), rt.new_int(2)])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_customer_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_customer := create_wc_customer(var_customer_id.clone())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		this.set_customer_source_data(mut rt.cast_object_ptr[Class_WC_Customer](var_customer))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }
	
	catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Exception') {
			mut var_e := var_e_1.clone()
			this.log((rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str(), @METHOD, (Class_WC_Log_Levels.error()).str())
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}
	
	end_label_1:
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('user_register'), rt.new_closure(closure_6_fn)])
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.register_order_origin_column()
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.new_closure(closure_7_fn)])
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		this.maybe_set_admin_source(mut rt.cast_object_ptr[Class_WC_Order](var_order))
		return rt.new_null()
		}
	rt.call_function('add_action', [rt.new_string('woocommerce_new_order'), rt.new_closure(closure_8_fn), rt.new_int(2), rt.new_int(10)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) maybe_set_admin_source(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_http_referer := rt.call_function('esc_url_raw', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')) } else { rt.new_string('') }])])
	mut var_referer_is_admin := rt.identical(rt.new_int(0), rt.call_function('strpos', [var_http_referer.clone(), rt.call_function('get_admin_url', []rt.PhpVal{})]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_referer_is_admin)))) && rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return
	}
	rt.call_method(var_order_mutated, 'add_meta_data', [this.get_meta_prefixed_field_name(rt.new_string('source_type')), rt.new_string('admin')])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) get_field_names() rt.PhpVal {
	return rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this), 'field_names')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) get_prefix() string {
	return (rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this), 'field_prefix')).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) enqueue_scripts_and_styles() {
	mut iife_temp_8 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_8 := iife_temp_8.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_script', [rt.new_string('sourcebuster-js'), rt.call_function('plugins_url', [rt.concat(rt.concat(rt.new_string('assets/js/sourcebuster/sourcebuster'), this.get_script_suffix()), rt.new_string('.js')), rt.get_constant('WC_PLUGIN_FILE')]), rt.new_array(), iife_result_8, rt.new_bool(true)])
	mut iife_temp_9 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_9 := iife_temp_9.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-order-attribution'), rt.call_function('plugins_url', [rt.concat(rt.concat(rt.new_string('assets/js/frontend/order-attribution'), this.get_script_suffix()), rt.new_string('.js')), rt.get_constant('WC_PLUGIN_FILE')]), rt.create_array([rt.ArrayItem{ key: none, val: 'sourcebuster-js' }]), iife_result_9, rt.new_bool(true)])
	mut var_lifetime := rt.new_float((rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_cookie_lifetime_months'), rt.new_float(1.0E-5)])).to_f64())
	mut var_session_length := rt.new_int((rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_session_length_minutes'), rt.new_int(30)])).to_i64())
	mut var_use_base64_cookies := rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_use_base64_cookies'), rt.new_bool(false)])
	mut var_allow_tracking := rt.call_function('wc_bool_to_string', [rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_allow_tracking'), rt.new_bool(true)])])
	mut var_namespace := rt.create_array([rt.ArrayItem{ key: 'params', val: rt.create_array([rt.ArrayItem{ key: 'lifetime', val: var_lifetime }, rt.ArrayItem{ key: 'session', val: var_session_length }, rt.ArrayItem{ key: 'base64', val: var_use_base64_cookies }, rt.ArrayItem{ key: 'ajaxurl', val: rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]) }, rt.ArrayItem{ key: 'prefix', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this), 'field_prefix') }, rt.ArrayItem{ key: 'allowTracking', val: rt.identical(rt.new_string('yes'), var_allow_tracking) }]) }, rt.ArrayItem{ key: 'fields', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this), 'fields') }])
	rt.call_function('wp_localize_script', [rt.new_string('wc-order-attribution'), rt.new_string('wc_order_attribution'), var_namespace.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) enqueue_admin_scripts_and_styles() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_screen, 'id'), this.get_order_screen_id())))) {
		return
	}
	mut iife_temp_10 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_10 := iife_temp_10.get_constant(rt.new_string('WC_VERSION'))
	rt.call_function('wp_enqueue_script', [rt.new_string('woocommerce-order-attribution-admin-js'), rt.call_function('plugins_url', [rt.concat(rt.concat(rt.new_string('assets/js/admin/order-attribution-admin'), this.get_script_suffix()), rt.new_string('.js')), rt.get_constant('WC_PLUGIN_FILE')]), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), iife_result_10])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) display_origin_column(var_order_id rt.PhpVal) {
	mut var_order := this.get_hpos_order_object(var_order_id.clone())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	this.output_origin_column(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		return
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) output_origin_column(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_source_type := rt.call_method(var_order_mutated, 'get_meta', [this.get_meta_prefixed_field_name(rt.new_string('source_type'))])
	mut var_source := rt.call_method(var_order_mutated, 'get_meta', [this.get_meta_prefixed_field_name(rt.new_string('utm_source'))])
	mut var_origin := this.get_origin_label(var_source_type.clone(), var_source.clone())
	rt.echo_val(rt.call_function('esc_html', [var_origin.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) stamp_checkout_html_element_once() {
	rt.call_function('wc_deprecated_function', [rt.new_string(@METHOD), rt.new_string('10.5.0'), rt.new_string('stamp_html_element')])
	this.stamp_html_element()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) stamp_html_element() {
	mut var_allow_multiple := rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_allow_multiple_elements'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_multiple)))) && rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', 'is_stamp_html_called')) {
		return
	}
	rt.call_function('printf', [rt.new_string('<wc-order-attribution-inputs></wc-order-attribution-inputs>')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_allow_multiple)))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', 'is_stamp_html_called', rt.new_bool(true))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) set_customer_source_data(mut var_customer Class_WC_Customer) {
	mut iter_2 := this.get_source_values(this.get_unprefixed_field_values(rt.get_superglobal('_POST').clone())).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		var_customer.add_meta_data(this.get_meta_prefixed_field_name(var_key.clone()), var_value.clone())
	}
	var_customer.save_meta_data()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) set_order_source_data(mut var_source_data Class_Automattic_WooCommerce_Internal_Orders_array, mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	if !rt.is_true(rt.call_function('array_filter', [var_source_data])) {
		return
	}
	mut iter_3 := var_source_data.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		rt.call_method(var_order_mutated, 'add_meta_data', [this.get_meta_prefixed_field_name(var_key.clone()), var_value.clone()])
	}
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) log(message string, method string, level string) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('apply_filters', [rt.new_string('wc_order_attribution_debug_mode_enabled'), rt.new_string('no')]))))) {
		return
	}
	rt.call_method(this.logger, 'log', [rt.new_string(level), rt.call_function('sprintf', [rt.new_string('%s %s'), rt.new_string(method), rt.new_string(message)]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-order-attribution' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) send_order_tracks(mut var_source_data Class_Automattic_WooCommerce_Internal_Orders_array, mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_origin_label := this.get_origin_label(if !(var_source_data.array_get(rt.new_string('source_type'))).is_null() { var_source_data.array_get(rt.new_string('source_type')) } else { rt.new_string('') }, if !(var_source_data.array_get(rt.new_string('utm_source'))).is_null() { var_source_data.array_get(rt.new_string('utm_source')) } else { rt.new_string('') }, rt.new_bool(false))
	mut var_tracks_data := rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'source_type', val: if !(var_source_data.array_get(rt.new_string('source_type'))).is_null() { var_source_data.array_get(rt.new_string('source_type')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'medium', val: if !(var_source_data.array_get(rt.new_string('utm_medium'))).is_null() { var_source_data.array_get(rt.new_string('utm_medium')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'source', val: if !(var_source_data.array_get(rt.new_string('utm_source'))).is_null() { var_source_data.array_get(rt.new_string('utm_source')) } else { rt.new_string('') } }, rt.ArrayItem{ key: 'device_type', val: if !(var_source_data.array_get(rt.new_string('device_type'))).is_null() { var_source_data.array_get(rt.new_string('device_type')) } else { rt.new_string('unknown') }.to_string().to_lower() }, rt.ArrayItem{ key: 'origin_label', val: var_origin_label.clone().to_string().to_lower() }, rt.ArrayItem{ key: 'session_pages', val: if !(var_source_data.array_get(rt.new_string('session_pages'))).is_null() { var_source_data.array_get(rt.new_string('session_pages')) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'session_count', val: if !(var_source_data.array_get(rt.new_string('session_count'))).is_null() { var_source_data.array_get(rt.new_string('session_count')) } else { rt.new_int(0) } }, rt.ArrayItem{ key: 'order_total', val: rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'customer_registered', val: if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{})) { 'yes' } else { 'no' } }])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_admin_record_tracks_event')])) {
		rt.call_function('wc_admin_record_tracks_event', [rt.new_string('order_attribution'), var_tracks_data.clone()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) get_order_screen_id() string {
	mut iife_temp_11 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_11 := iife_temp_11.custom_orders_table_usage_is_enabled()
	return (if rt.is_true(iife_result_11) { rt.call_function('wc_get_page_screen_id', [rt.new_string('shop-order')]) } else { rt.new_string('shop_order') }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) register_order_origin_column() {
	mut var_screen_id := rt.new_string(this.get_order_screen_id())
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_columns := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_columns.array_set('origin', rt.call_function('esc_html__', [rt.new_string('Origin'), rt.new_string('woocommerce')]))
		return
		}
	mut var_add_column := rt.new_closure(closure_13_fn)
	rt.call_function('add_filter', [rt.new_string("manage_${var_screen_id.to_string()}_columns"), var_add_column.clone()])
	rt.call_function('add_filter', [rt.new_string("manage_edit-${var_screen_id.to_string()}_columns"), var_add_column.clone()])
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_column_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order_id := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('origin'), var_column_name)))) {
			return
		}
		this.display_origin_column(var_order_id.clone())
		return rt.new_null()
		}
	mut var_display_column := rt.new_closure(closure_14_fn)
	rt.call_function('add_action', [rt.new_string("manage_${var_screen_id.to_string()}_custom_column"), var_display_column.clone(), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string("manage_${var_screen_id.to_string()}_posts_custom_column"), var_display_column.clone(), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) has_attribution(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut iter_4 := rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Orders_OrderAttributionController', ['RegisterHooksInterface'], &this), 'field_names').iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_field := item_4.val
		if rt.is_true(rt.call_method(var_order_mutated, 'meta_exists', [this.get_meta_prefixed_field_name(var_field.clone())])) {
			return true
		}
	}
	return false
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orders_orderattributioncontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController{
		PhpObjectBase: rt.PhpObjectBase{}
		consent: rt.new_null()
		feature_controller: rt.new_null()
		logger: rt.new_null()
		proxy: rt.new_null()
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_FeaturesController](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Integrations_WPConsentAPI](if args.len > 2 { args[2] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'maybe_set_admin_source' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.maybe_set_admin_source(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_field_names' {
			return this.get_field_names()
		}
		'get_prefix' {
			return rt.new_string(this.get_prefix())
		}
		'enqueue_scripts_and_styles' {
			this.enqueue_scripts_and_styles()
			return rt.new_null()
		}
		'enqueue_admin_scripts_and_styles' {
			this.enqueue_admin_scripts_and_styles()
			return rt.new_null()
		}
		'display_origin_column' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_origin_column(dispatch_arg_0)
			return rt.new_null()
		}
		'output_origin_column' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.output_origin_column(mut dispatch_arg_0)
			return rt.new_null()
		}
		'stamp_checkout_html_element_once' {
			this.stamp_checkout_html_element_once()
			return rt.new_null()
		}
		'stamp_html_element' {
			this.stamp_html_element()
			return rt.new_null()
		}
		'set_customer_source_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Customer](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_customer_source_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_source_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.set_order_source_data(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'log' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.log(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'send_order_tracks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Orders_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			this.send_order_tracks(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_order_screen_id' {
			return rt.new_string(this.get_order_screen_id())
		}
		'register_order_origin_column' {
			this.register_order_origin_column()
			return rt.new_null()
		}
		'has_attribution' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_attribution(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'consent' { return this.consent }
		'feature_controller' { return this.feature_controller }
		'logger' { return this.logger }
		'proxy' { return this.proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderAttributionController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'consent' { this.consent = val; return true }
		'feature_controller' { this.feature_controller = val; return true }
		'logger' { this.logger = val; return true }
		'proxy' { this.proxy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
