import rt

pub fn Class_WC_Tracks_Client.pixel() string {
	return 'https://pixel.wp.com/t.gif'
}

pub fn Class_WC_Tracks_Client.browser_type() string {
	return 'php-agent'
}

pub fn Class_WC_Tracks_Client.user_agent_slug() string {
	return 'tracks-client'
}

struct Class_WC_Tracks_Client {
	rt.PhpObjectBase
}

fn init_static_wc_tracks_client() {
	rt.init_static_prop('WC_Tracks_Client', 'pixel_batch_queue', rt.new_array())
	rt.init_static_prop('WC_Tracks_Client', 'shutdown_hook_registered', rt.new_bool(false))
}

fn Class_WC_Tracks_Client.init() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_set_identity_cookie' }])])
}

fn Class_WC_Tracks_Client.maybe_set_identity_cookie() bool {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('DOING_AJAX'))
	if rt.is_true(iife_result_0) {
		return false
	}
	if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) {
		return false
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.instance_of(var_user, 'WP_User')))
		&& rt.is_true(rt.identical(rt.new_string('wptests_capabilities'), rt.get_property(var_user, 'cap_key'))) {
		return false
	}
	mut var_user_id := rt.get_property(var_user, 'ID')
	mut var_anon_id := rt.call_function('get_user_meta', [var_user_id.clone(),
		rt.new_string('_woocommerce_tracks_anon_id'), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_anon_id)))) {
		var_anon_id = Class_WC_Tracks_Client.get_anon_id()
		rt.call_function('update_user_meta', [var_user_id.clone(),
			rt.new_string('_woocommerce_tracks_anon_id'), var_anon_id.clone()])
	}
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_true(rt.new_string('REST_REQUEST'))
	mut iife_temp_2 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_2 := iife_temp_2.is_true(rt.new_string('XMLRPC_REQUEST'))
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_2)))) {
		mut iife_temp_3 := Class_WC_Site_Tracking{}
		mut iife_result_3 := iife_temp_3.set_tracking_cookie(rt.new_string('tk_ai'),
			var_anon_id.clone())
	}
	return false
}

fn Class_WC_Tracks_Client.record_event(var_event rt.PhpVal) rt.PhpVal {
	mut var_event_mutated := var_event
	if !(true) {
		var_event_mutated = create_wc_tracks_event(var_event_mutated.clone())
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_event_mutated.clone()])) {
		return var_event_mutated.clone()
	}
	mut var_pixel := var_event_mutated.build_pixel_url(var_event_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pixel)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_pixel'),
			rt.new_string('cannot generate tracks pixel for given input'), rt.new_int(400)))
	}
	return Class_WC_Tracks_Client.record_pixel(var_pixel.clone())
}

fn Class_WC_Tracks_Client.record_event_batched(var_event rt.PhpVal) rt.PhpVal {
	mut var_event_mutated := var_event
	if !(true) {
		var_event_mutated = create_wc_tracks_event(var_event_mutated.clone())
	}
	if !(rt.get_property(var_event_mutated, 'error')).is_null()
		&& rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_event_mutated, 'error')])) {
		return rt.get_property(var_event_mutated, 'error')
	}
	mut var_pixel := var_event_mutated.build_pixel_url()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pixel)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_pixel'),
			rt.new_string('cannot generate tracks pixel for given input'), rt.new_int(400)))
	}
	return Class_WC_Tracks_Client.record_pixel_batched(var_pixel.clone())
}

fn Class_WC_Tracks_Client.record_pixel(var_pixel rt.PhpVal) bool {
	mut var_pixel_mutated := var_pixel
	var_pixel_mutated =
		Class_WC_Tracks_Client.add_request_timestamp_and_nocache(var_pixel_mutated.clone())
	rt.call_function('wp_safe_remote_get', [var_pixel_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'blocking', val: false },
			rt.ArrayItem{ key: 'redirection', val: 2 }, rt.ArrayItem{ key: 'httpversion', val: '1.1' },
			rt.ArrayItem{ key: 'timeout', val: 1 }])])
	return true
}

fn Class_WC_Tracks_Client.record_pixel_batched(var_pixel rt.PhpVal) bool {
	mut var_pixel_mutated := var_pixel
	mut var_use_batching := Class_WC_Tracks_Client.can_use_batch_requests()
	var_use_batching = rt.call_function('apply_filters', [
		rt.new_string('wc_tracks_use_batch_requests'),
		var_use_batching.clone(),
	])
	if rt.is_true(var_use_batching) {
		Class_WC_Tracks_Client.queue_pixel_for_batch(var_pixel_mutated.str())
		return true
	}
	return (Class_WC_Tracks_Client.record_pixel(var_pixel_mutated.clone())).to_bool()
}

fn Class_WC_Tracks_Client.build_timestamp() rt.PhpVal {
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_4 := iife_temp_4.round(rt.mul(rt.call_function('microtime', [
		rt.new_bool(true),
	]), rt.new_int(1000)))
	mut var_ts := iife_result_4
	return rt.call_function('number_format', [var_ts.clone(),
		rt.new_int(0), rt.new_string(''), rt.new_string('')])
}

fn Class_WC_Tracks_Client.add_request_timestamp_and_nocache(var_pixel rt.PhpVal) rt.PhpVal {
	mut var_pixel_mutated := var_pixel
	var_pixel_mutated = rt.concat(var_pixel_mutated, rt.new_string('&_rt=' +
		(Class_WC_Tracks_Client.build_timestamp()).str() + '&_=_'))
	return var_pixel_mutated.clone()
}

fn Class_WC_Tracks_Client.get_identity(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	mut var_jetpack_lib := rt.new_string('/tracks/client.php')
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.is_defined(rt.new_string('JETPACK__VERSION'))
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_5) {
		mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('JETPACK__VERSION'))
		mut iife_temp_7 := Class_Automattic_Jetpack_Constants{}
		mut iife_result_7 := iife_temp_7.get_constant(rt.new_string('JETPACK__VERSION'))
		if rt.is_true(rt.call_function('version_compare', [iife_result_6, rt.new_string('7.5'),
			rt.new_string('<')]))
		{
			if rt.is_true(rt.call_function('file_exists', [
				rt.new_string((rt.call_function('jetpack_require_lib_dir', []rt.PhpVal{})).str() +
					var_jetpack_lib.str()),
			]))
			{
				rt.include_file(
					(rt.call_function('jetpack_require_lib_dir', []rt.PhpVal{})).str() +
					var_jetpack_lib.str(), '2')
				if rt.is_true(rt.call_function('function_exists', [
					rt.new_string('jetpack_tracks_get_identity'),
				]))
				{
					return rt.call_function('jetpack_tracks_get_identity', [
						var_user_id_mutated.clone()])
				}
			}
		} else {
			mut var_tracking := create_automattic_jetpack_tracking()
			return var_tracking.tracks_get_identity(var_user_id_mutated.clone())
		}
	}
	mut var_anon_id := if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))]),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_anon_id)))) {
		var_anon_id = rt.call_function('get_user_meta', [var_user_id_mutated.clone(),
			rt.new_string('_woocommerce_tracks_anon_id'), rt.new_bool(true)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_anon_id)))) {
		var_anon_id = Class_WC_Tracks_Client.get_anon_id()
		rt.call_function('update_user_meta', [var_user_id_mutated.clone(),
			rt.new_string('_woocommerce_tracks_anon_id'), var_anon_id.clone()])
	}
	return rt.create_array([rt.ArrayItem{ key: '_ut', val: 'anon' },
		rt.ArrayItem{ key: '_ui', val: var_anon_id }])
}

fn Class_WC_Tracks_Client.get_anon_id() rt.PhpVal {
	mut var_anon_id := rt.new_null()
	if !(!var_anon_id.is_null()) {
		if rt.get_superglobal('_COOKIE').array_isset(rt.new_string('tk_ai')) {
			var_anon_id = rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_COOKIE').array_get(rt.new_string('tk_ai'))]),
			])
		} else {
			mut var_binary := rt.new_string('')
			mut var_i := rt.new_int(0)
			for {
				if !(rt.is_true(rt.less(var_i, rt.new_int(18)))) { break
				 }
				var_binary = rt.concat(var_binary, rt.call_function('chr', [
					rt.call_function('wp_rand', [rt.new_int(0),
						rt.new_int(255)]),
				]))
				rt.pre_inc(var_i)
			}
			var_anon_id = rt.new_string('woo:' +
				(rt.call_function('base64_encode', [var_binary.clone()])).str())
		}
	}
	return var_anon_id.clone()
}

fn Class_WC_Tracks_Client.can_use_batch_requests() bool {
	return
		rt.is_true(rt.call_function('class_exists', [rt.new_string('WpOrg\\Requests\\Requests')]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_string('WpOrg\\Requests\\Requests'), rt.new_string('request_multiple')]))
		|| rt.is_true(rt.call_function('class_exists', [rt.new_string('Requests')]))
		&& rt.is_true(rt.call_function('method_exists', [rt.new_string('Requests'), rt.new_string('request_multiple')]))
	return false
}

fn Class_WC_Tracks_Client.queue_pixel_for_batch(pixel string) {
	mut pixel_mutated := pixel
	rt.get_static_prop('WC_Tracks_Client', 'pixel_batch_queue').array_push(pixel_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('WC_Tracks_Client',
		'shutdown_hook_registered')))))
	{
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'send_batched_pixels' }]),
			rt.new_int(20)])
		rt.set_static_prop('WC_Tracks_Client', 'shutdown_hook_registered', rt.new_bool(true))
	}
}

fn Class_WC_Tracks_Client.send_batched_pixels() {
	if !rt.is_true(rt.get_static_prop('WC_Tracks_Client', 'pixel_batch_queue')) {
		return
	}
	mut var_pixels_to_send := rt.new_array()
	mut iter_1 := rt.get_static_prop('WC_Tracks_Client', 'pixel_batch_queue').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_pixel := item_1.val
		var_pixels_to_send << Class_WC_Tracks_Client.add_request_timestamp_and_nocache(var_pixel.clone())
	}
	Class_WC_Tracks_Client.send_with_requests_multiple(mut rt.cast_object_ptr[Class_array](var_pixels_to_send))
	rt.set_static_prop('WC_Tracks_Client', 'pixel_batch_queue', rt.new_array())
}

fn Class_WC_Tracks_Client.send_with_requests_multiple(mut var_pixels Class_array) {
	mut var_requests := rt.new_array()
	mut var_options := {
		'blocking': rt.new_bool(false)
		'timeout':  rt.new_int(1)
	}
	mut iter_2 := var_pixels.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_pixel := item_2.val
		var_requests << rt.create_array([rt.ArrayItem{ key: 'url', val: var_pixel },
			rt.ArrayItem{ key: 'headers', val: rt.new_array() },
			rt.ArrayItem{ key: 'data', val: rt.new_array() },
			rt.ArrayItem{ key: 'type', val: 'GET' }])
	}
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WpOrg\\Requests\\Requests'),
	]))
	{
		mut iife_temp_8 := Class_WpOrg_Requests_Requests{}
		mut iife_result_8 := iife_temp_8.request_multiple(var_requests.clone(), var_options.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else if rt.is_true(rt.call_function('class_exists', [rt.new_string('Requests')])) {
		mut iife_temp_9 := Class_Requests{}
		mut iife_result_9 := iife_temp_9.request_multiple(var_requests.clone(), var_options.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
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
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_get_logger'),
		]))
		{
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [
				rt.new_string('WC_Tracks_Client: Batch pixel request failed - ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
				rt.create_array([rt.ArrayItem{ key: 'source', val: 'wc-tracks' }]),
			])
		}
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
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Site_Tracking {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Event {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Tracking {
	rt.PhpObjectBase
}

struct Class_WpOrg_Requests_Requests {
	rt.PhpObjectBase
}

struct Class_Requests {
	rt.PhpObjectBase
}

fn create_wc_tracks_client(_args ...rt.PhpVal) &Class_WC_Tracks_Client {
	mut obj := &Class_WC_Tracks_Client{
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

fn create_wc_site_tracking(_args ...rt.PhpVal) &Class_WC_Site_Tracking {
	mut obj := &Class_WC_Site_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_event(_args ...rt.PhpVal) &Class_WC_Tracks_Event {
	mut obj := &Class_WC_Tracks_Event{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_tracking(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Tracking {
	mut obj := &Class_Automattic_Jetpack_Tracking{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wporg_requests_requests(_args ...rt.PhpVal) &Class_WpOrg_Requests_Requests {
	mut obj := &Class_WpOrg_Requests_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_requests(_args ...rt.PhpVal) &Class_Requests {
	mut obj := &Class_Requests{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tracks_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Tracks_Client.init()
			return rt.new_null()
		}
		'maybe_set_identity_cookie' {
			return rt.new_bool(Class_WC_Tracks_Client.maybe_set_identity_cookie())
		}
		'record_event' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Client.record_event(dispatch_arg_0)
		}
		'record_event_batched' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Client.record_event_batched(dispatch_arg_0)
		}
		'record_pixel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tracks_Client.record_pixel(dispatch_arg_0))
		}
		'record_pixel_batched' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Tracks_Client.record_pixel_batched(dispatch_arg_0))
		}
		'build_timestamp' {
			return Class_WC_Tracks_Client.build_timestamp()
		}
		'add_request_timestamp_and_nocache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Client.add_request_timestamp_and_nocache(dispatch_arg_0)
		}
		'get_identity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Client.get_identity(dispatch_arg_0)
		}
		'get_anon_id' {
			return Class_WC_Tracks_Client.get_anon_id()
		}
		'can_use_batch_requests' {
			return rt.new_bool(Class_WC_Tracks_Client.can_use_batch_requests())
		}
		'queue_pixel_for_batch' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Tracks_Client.queue_pixel_for_batch(dispatch_arg_0)
			return rt.new_null()
		}
		'send_batched_pixels' {
			Class_WC_Tracks_Client.send_batched_pixels()
			return rt.new_null()
		}
		'send_with_requests_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			Class_WC_Tracks_Client.send_with_requests_multiple(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Tracks_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Site_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Site_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Site_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Tracking) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Tracking) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Tracking) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WpOrg_Requests_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WpOrg_Requests_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Requests) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Requests) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Requests) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Tracks_Client.init()
}
