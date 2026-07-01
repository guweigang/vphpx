import rt

struct Class_WC_Coupons_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Coupons_Tracking) init()  {
	rt.call_function('add_action', [rt.new_string('load-edit.php'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Coupons_Tracking', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'tracks_coupons_events' }]), rt.new_int(10)])
}

fn (mut this Class_WC_Coupons_Tracking) tracks_coupons_bulk_actions()  {
	mut var_handle := rt.new_string(rt.new_string('wc-tracks-coupons-bulk-actions'))
	rt.call_function('wp_register_script', [var_handle.dup(), rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.dup()])
	rt.call_function('wp_add_inline_script', [var_handle.dup(), rt.new_string('\n\t\t\t\t(function() {\n\t\t\t\t    \'use strict\';\n\n\t\t\t\t    function trackBulkAction( selectorId ) {\n\t\t\t\t        return function() {\n\t\t\t\t            const select = document.getElementById( selectorId );\n\t\t\t\t            const action = select ? select.value : null;\n\n\t\t\t\t            if ( action && \'-1\' !== action && window.wcTracks && window.wcTracks.recordEvent ) {\n\t\t\t\t                window.wcTracks.recordEvent( \'coupons_view_bulk_action\', { action: action } );\n\t\t\t\t            }\n\t\t\t\t        };\n\t\t\t\t    }\n\n\t\t\t\t    const topButton = document.getElementById( \'doaction\' );\n\t\t\t\t    const bottomButton = document.getElementById( \'doaction2\' );\n\n\t\t\t\t    if ( topButton ) {\n\t\t\t\t        topButton.addEventListener( \'click\', trackBulkAction( \'bulk-action-selector-top\' ) );\n\t\t\t\t    }\n\n\t\t\t\t    if ( bottomButton ) {\n\t\t\t\t        bottomButton.addEventListener( \'click\', trackBulkAction( \'bulk-action-selector-bottom\' ) );\n\t\t\t\t    }\n\t\t\t\t})();\n\t\t\t')])
}

fn (mut this Class_WC_Coupons_Tracking) tracks_coupons_events()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.get_superglobal('_GET').array_get('post_type'))))) {
		this.tracks_coupons_bulk_actions()
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('coupons_view'), rt.create_array([rt.ArrayItem{ key: 'status', val: if rt.get_superglobal('_GET').array_isset(rt.new_string('post_status')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('post_status')])]) } else { rt.new_string('all') } }]))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('filter_action')) && rt.is_true(rt.identical(rt.new_string('Filter'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('filter_action')])]))))) && rt.get_superglobal('_GET').array_isset(rt.new_string('coupon_type')))) {
			fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0, arg_1) }(rt.new_string('coupons_filter'), rt.create_array([rt.ArrayItem{ key: 'filter', val: 'coupon_type' }, rt.ArrayItem{ key: 'value', val: rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('coupon_type')])]) }]))
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('s')) && 0 < rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('s')])]).to_string().len {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks{}; return temp.record_event(arg_0) }(rt.new_string('coupons_search'))
		}
	}
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_coupons_tracking() &Class_WC_Coupons_Tracking {
	mut obj := &Class_WC_Coupons_Tracking{
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

fn (mut this Class_WC_Coupons_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'tracks_coupons_bulk_actions' {
			this.tracks_coupons_bulk_actions()
			return rt.new_null()
		}
		'tracks_coupons_events' {
			this.tracks_coupons_events()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Coupons_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupons_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_tracks_events_class_wc_coupons_tracking_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
