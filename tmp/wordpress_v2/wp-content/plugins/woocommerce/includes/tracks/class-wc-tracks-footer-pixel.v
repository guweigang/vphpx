import rt

struct Class_WC_Tracks_Footer_Pixel {
	rt.PhpObjectBase
pub mut:
	events rt.PhpVal = rt.new_array()
}

fn init_static_wc_tracks_footer_pixel() {
	rt.init_static_prop('WC_Tracks_Footer_Pixel', 'instance', rt.new_null())
}

fn Class_WC_Tracks_Footer_Pixel.instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.get_static_prop('WC_Tracks_Footer_Pixel', 'instance').is_null())) {
		rt.set_static_prop('WC_Tracks_Footer_Pixel', 'instance', rt.new_object('WC_Tracks_Footer_Pixel',
			[]string{}, create_wc_tracks_footer_pixel()))
	}
	return rt.get_static_prop('WC_Tracks_Footer_Pixel', 'instance')
}

fn (mut this Class_WC_Tracks_Footer_Pixel) construct() {
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Tracks_Footer_Pixel', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_tracking_pixels' },
		])])
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Tracks_Footer_Pixel', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'send_tracks_requests' },
		])])
}

fn Class_WC_Tracks_Footer_Pixel.record_event(var_event rt.PhpVal) bool {
	mut var_event_mutated := var_event
	if !(true) {
		var_event_mutated = create_wc_tracks_event(var_event_mutated.clone())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_event_mutated.clone()])) {
		return var_event_mutated.to_bool()
	}
	rt.call_method(Class_WC_Tracks_Footer_Pixel.instance(), 'add_event', [
		var_event_mutated.clone()])
	return true
}

fn (mut this Class_WC_Tracks_Footer_Pixel) add_event(var_event rt.PhpVal) {
	mut var_event_mutated := var_event
	this.events.array_push(var_event_mutated.clone())
}

fn (mut this Class_WC_Tracks_Footer_Pixel) render_tracking_pixels() {
	if !rt.is_true(this.events) {
		return
	}
	mut iter_1 := this.events.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_event := item_1.val
		mut var_pixel := rt.call_method(var_event, 'build_pixel_url', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_pixel)))) {
			continue
		}
		mut iife_temp_0 := Class_WC_Tracks_Client{}
		mut iife_result_0 := iife_temp_0.add_request_timestamp_and_nocache(var_pixel.clone())
		var_pixel = iife_result_0
		print('<img style="position: fixed;" src="')
		rt.echo_val(rt.call_function('esc_url', [var_pixel.clone()]))
		print('" />')
	}
	this.events = rt.new_array()
}

fn (mut this Class_WC_Tracks_Footer_Pixel) send_tracks_requests() {
	if !rt.is_true(this.events) {
		return
	}
	mut iter_2 := this.events.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_event := item_2.val
		mut iife_temp_1 := Class_WC_Tracks_Client{}
		mut iife_result_1 := iife_temp_1.record_event(var_event.clone())
	}
}

fn Class_WC_Tracks_Footer_Pixel.get_events() rt.PhpVal {
	return rt.get_property(Class_WC_Tracks_Footer_Pixel.instance(), 'events')
}

fn Class_WC_Tracks_Footer_Pixel.clear_events() {
	rt.set_property(Class_WC_Tracks_Footer_Pixel.instance(), 'events', rt.new_array())
}

struct Class_WC_Tracks_Event {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Client {
	rt.PhpObjectBase
}

fn create_wc_tracks_footer_pixel() &Class_WC_Tracks_Footer_Pixel {
	mut obj := &Class_WC_Tracks_Footer_Pixel{
		PhpObjectBase: rt.PhpObjectBase{}
		events:        rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wc_tracks_event(_args ...rt.PhpVal) &Class_WC_Tracks_Event {
	mut obj := &Class_WC_Tracks_Event{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_client(_args ...rt.PhpVal) &Class_WC_Tracks_Client {
	mut obj := &Class_WC_Tracks_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tracks_Footer_Pixel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_WC_Tracks_Footer_Pixel.instance()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'record_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tracks_Footer_Pixel.record_event(dispatch_arg_0))
		}
		'add_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_event(dispatch_arg_0)
			return rt.new_null()
		}
		'render_tracking_pixels' {
			this.render_tracking_pixels()
			return rt.new_null()
		}
		'send_tracks_requests' {
			this.send_tracks_requests()
			return rt.new_null()
		}
		'get_events' {
			return Class_WC_Tracks_Footer_Pixel.get_events()
		}
		'clear_events' {
			Class_WC_Tracks_Footer_Pixel.clear_events()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Tracks_Footer_Pixel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'events' { return this.events }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Tracks_Footer_Pixel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'events' {
			this.events = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Tracks_Event) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Event) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Event) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracks_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
