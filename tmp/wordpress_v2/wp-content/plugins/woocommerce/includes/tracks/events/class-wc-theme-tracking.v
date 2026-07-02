import rt

struct Class_WC_Theme_Tracking {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Theme_Tracking) init() {
	this.track_initial_theme()
	rt.call_function('add_action', [rt.new_string('switch_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Theme_Tracking', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'track_activated_theme' },
		])])
}

fn (mut this Class_WC_Theme_Tracking) track_initial_theme() {
	mut var_has_been_initially_tracked := rt.call_function('get_option', [
		rt.new_string('wc_has_tracked_default_theme'),
	])
	if rt.is_true(var_has_been_initially_tracked) {
		return
	}
	this.track_activated_theme()
	rt.call_function('add_option', [rt.new_string('wc_has_tracked_default_theme'),
		rt.new_int(1)])
}

fn (mut this Class_WC_Theme_Tracking) track_activated_theme() {
	mut var_is_block_theme := rt.call_function('wp_is_block_theme', []rt.PhpVal{})
	mut var_theme_object := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_properties := {
		'block_theme':   var_is_block_theme
		'theme_name':    rt.call_method(var_theme_object, 'get', [
			rt.new_string('Name')])
		'theme_version': rt.call_method(var_theme_object, 'get', [
			rt.new_string('Version'),
		])
	}
	mut iife_temp_0 := Class_WC_Tracks{}
	mut iife_result_0 := iife_temp_0.record_event(rt.new_string('activated_theme'),
		var_properties.clone())
}

struct Class_WC_Tracks {
	rt.PhpObjectBase
}

fn create_wc_theme_tracking(_args ...rt.PhpVal) &Class_WC_Theme_Tracking {
	mut obj := &Class_WC_Theme_Tracking{
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

fn (mut this Class_WC_Theme_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'track_initial_theme' {
			this.track_initial_theme()
			return rt.new_null()
		}
		'track_activated_theme' {
			this.track_activated_theme()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Theme_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Theme_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
