import rt

struct Class_WC_Status_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Status_Tracking) init() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Status_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_status_view' },
		]),
		rt.new_int(10)])
}

fn (mut this Class_WC_Status_Tracking) track_status_view() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('wc-status'), rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('page'))])]))) {
		mut var_tab := if rt.get_superglobal('_GET').array_isset(rt.new_string('tab')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('tab'))]),
			]) } else { rt.new_string('status') }
		mut iife_temp_0 := Class_WC_Tracks{}
		mut iife_result_0 := iife_temp_0.record_event(rt.new_string('status_view'), rt.create_array([
			rt.ArrayItem{ key: 'tab', val: var_tab },
			rt.ArrayItem{
				key: 'tool_used'
				val: if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) { rt.call_function('sanitize_text_field', [
						rt.call_function('wp_unslash', [
							rt.get_superglobal('_GET').array_get(rt.new_string('action')),
						]),
					]) } else { rt.new_null() }
			},
		]))
		if rt.is_true(rt.identical(rt.new_string('status'), var_tab)) {
			mut var_handle := rt.new_string('wc-tracks-status-view')
			rt.call_function('wp_register_script', [var_handle.clone(),
				rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'),
				rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
			rt.call_function('wp_enqueue_script', [var_handle.clone()])
			rt.call_function('wp_add_inline_script', [var_handle.clone(),
				rt.new_string("\n\t\t\t            (function() {\n\t\t\t                'use strict';\n\t\t\t                const debugReportLink = document.querySelector( 'a.debug-report' );\n\t\t\t                if ( debugReportLink ) {\n\t\t\t                    debugReportLink.addEventListener( 'click', function() {\n\t\t\t                        if ( window.wcTracks && window.wcTracks.recordEvent ) {\n\t\t\t                            window.wcTracks.recordEvent( 'status_view_reports' );\n\t\t\t                        }\n\t\t\t                    } );\n\t\t\t                }\n\t\t\t            })();\n                    ")])
		}
	}
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_status_tracking(_args ...rt.PhpVal) &Class_WC_Status_Tracking {
	mut obj := &Class_WC_Status_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks(_args ...rt.PhpVal) &Class_WC_Tracks {
	mut obj := &Class_WC_Tracks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Status_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_status_view' {
			this.track_status_view()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Status_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Status_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
