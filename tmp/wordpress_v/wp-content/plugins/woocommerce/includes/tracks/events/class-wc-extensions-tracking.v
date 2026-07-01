import rt

struct Class_WC_Extensions_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Extensions_Tracking) init()  {
	rt.call_function('add_action', [rt.new_string('load-woocommerce_page_wc-addons'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_extensions_page' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_connect_start'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_helper_connection_start' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_denied'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_helper_connection_cancelled' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_connected'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_helper_connection_complete' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_disconnected'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_helper_disconnected' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_helper_subscriptions_refresh'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_helper_subscriptions_refresh' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_addon_installed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_addon_install' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_page_wc-addons_connection_error'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Extensions_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'track_extensions_page_connection_error' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_WC_Extensions_Tracking) track_extensions_page()  {
	mut var_properties := { 'section': if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('section')) { rt.new_string('_featured') } else { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('section')])]) } }
	mut var_event := rt.new_string(rt.new_string('extensions_view'))
	if rt.is_true(rt.identical(rt.new_string('helper'), var_properties.array_get('section'))) {
		var_event = rt.new_string(rt.new_string('subscriptions_view'))
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('search'))) {
		var_event = rt.new_string(rt.new_string('extensions_view_search'))
		var_properties['search_term'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('search')])])
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(var_event.dup(), var_properties.dup())
}

fn (mut this Class_WC_Extensions_Tracking) track_extensions_page_connection_error(error string)  {
	mut var_properties := { 'section': if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('section')) { rt.new_string('_featured') } else { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('section')])]) } }
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('search'))) {
		var_properties['search_term'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('search')])])
	}
	if !(error == '') {
		var_properties['error_data'] = rt.new_string(error).dup()
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('extensions_view_connection_error'), var_properties.dup())
}

fn (mut this Class_WC_Extensions_Tracking) track_helper_connection_start()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0) }(rt.new_string('extensions_subscriptions_connect'))
}

fn (mut this Class_WC_Extensions_Tracking) track_helper_connection_cancelled()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0) }(rt.new_string('extensions_subscriptions_cancelled'))
}

fn (mut this Class_WC_Extensions_Tracking) track_helper_connection_complete()  {
	mut var_properties := map[string]rt.PhpVal{}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('utm_source'))) {
		var_properties['utm_source'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('utm_source')])])
		// unsupported statement: Stmt_Nop
	}
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('utm_campaign'))) {
		var_properties['utm_campaign'] = rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('utm_campaign')])])
		// unsupported statement: Stmt_Nop
	}
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('extensions_subscriptions_connected'), var_properties.dup())
}

fn (mut this Class_WC_Extensions_Tracking) track_helper_disconnected()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0) }(rt.new_string('extensions_subscriptions_disconnect'))
}

fn (mut this Class_WC_Extensions_Tracking) track_helper_subscriptions_refresh()  {
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0) }(rt.new_string('extensions_subscriptions_update'))
}

fn (mut this Class_WC_Extensions_Tracking) track_addon_install(var_addon_id rt.PhpVal, var_section rt.PhpVal)  {
	mut var_properties := { 'context': rt.new_string('extensions'), 'section': var_section }
	if rt.is_true(rt.identical(rt.new_string('woocommerce-payments'), var_addon_id)) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('woocommerce_payments_install'), var_properties.dup())
	}
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_extensions_tracking() &Class_WC_Extensions_Tracking {
	mut obj := &Class_WC_Extensions_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks() &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Extensions_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_extensions_page' {
			this.track_extensions_page()
			return rt.new_null()
		}
		'track_extensions_page_connection_error' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.track_extensions_page_connection_error(dispatch_arg_0)
			return rt.new_null()
		}
		'track_helper_connection_start' {
			this.track_helper_connection_start()
			return rt.new_null()
		}
		'track_helper_connection_cancelled' {
			this.track_helper_connection_cancelled()
			return rt.new_null()
		}
		'track_helper_connection_complete' {
			this.track_helper_connection_complete()
			return rt.new_null()
		}
		'track_helper_disconnected' {
			this.track_helper_disconnected()
			return rt.new_null()
		}
		'track_helper_subscriptions_refresh' {
			this.track_helper_subscriptions_refresh()
			return rt.new_null()
		}
		'track_addon_install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.track_addon_install(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Extensions_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Extensions_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tracks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_extensions_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
