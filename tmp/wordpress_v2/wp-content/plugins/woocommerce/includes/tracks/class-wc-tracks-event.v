import rt

pub fn Class_WC_Tracks_Event.event_name_regex() string {
	return '/^(([a-z0-9]+)_){1}([a-z0-9_]+)$/'
}

pub fn Class_WC_Tracks_Event.prop_name_regex() string {
	return '/^[a-z_][a-z0-9_]*$/'
}

struct Class_WC_Tracks_Event {
	rt.PhpObjectBase
pub mut:
	error rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Tracks_Event) construct(var_event rt.PhpVal) {
	mut var_event_mutated := var_event
	mut var__event := Class_WC_Tracks_Event.validate_and_sanitize(var_event_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var__event.clone()])) {
		this.error = var__event.clone()
		return
	}
	mut iter_1 := var__event.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":48,"name":"key"}',
			var_value.clone())
	}
}

fn (mut this Class_WC_Tracks_Event) record() rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('REST_REQUEST'))
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.is_true(rt.new_string('WP_CLI'))
	if rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(iife_result_0)
		|| rt.is_true(iife_result_1) || rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})) {
		mut iife_temp_2 := Class_WC_Tracks_Client{}
		mut iife_result_2 :=
			iife_temp_2.record_event(rt.new_object('WC_Tracks_Event', []string{}, this))
		return iife_result_2
	}
	mut iife_temp_3 := Class_WC_Tracks_Footer_Pixel{}
	mut iife_result_3 :=
		iife_temp_3.record_event(rt.new_object('WC_Tracks_Event', []string{}, this))
	return iife_result_3
}

fn Class_WC_Tracks_Event.validate_and_sanitize(var_event rt.PhpVal) rt.PhpVal {
	mut var_event_mutated := var_event
	var_event_mutated = rt.array_to_object(var_event_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_event_mutated, '_en'))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_event'),
			rt.new_string('A valid event must be specified via `_en`'), rt.new_int(400)))
	}
	if rt.is_true(rt.call_function('property_exists', [var_event_mutated.clone(), rt.new_string('_via_ip')]))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^192\\.168|^10\\./'), rt.get_property(var_event_mutated, '_via_ip')])) {
		rt.get_property(var_event_mutated, '_via_ip') = rt.new_null()
	}
	mut var_validated := rt.create_array([
		rt.ArrayItem{ key: 'browser_type', val: Class_WC_Tracks_Client.browser_type() },
	])
	mut var__event := rt.array_to_object(rt.call_function('array_merge', [
		rt.cast_array(var_event_mutated),
		var_validated.clone(),
	]))
	if !(!(rt.get_property(var__event, '_ts')).is_null()) {
		mut iife_temp_4 := Class_WC_Tracks_Client{}
		mut iife_result_4 := iife_temp_4.build_timestamp()
		rt.set_property(var__event, '_ts', iife_result_4)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.event_name_is_valid(rt.get_property(var__event,
		'_en'))))))
	{
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_event_name'), rt.call_function('__', [
			rt.new_string('A valid event name must be specified.'),
			rt.new_string('woocommerce'),
		])))
	}
	mut iter_2 := rt.func_array_keys(rt.cast_array(var__event)).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.prop_name_is_valid(var_key.clone())))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_en'), var_key)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_prop_name'), rt.call_function('__', [
				rt.new_string('A valid prop name must be specified'),
				rt.new_string('woocommerce'),
			])))
		}
	}
	var__event = Class_WC_Tracks_Event.sanitize_property_values(var__event.clone())
	return var__event.clone()
}

fn (mut this Class_WC_Tracks_Event) build_pixel_url() string {
	if rt.is_true(this.error) {
		return ''
	}
	mut var_args := rt.call_function('get_object_vars', [
		rt.new_object('WC_Tracks_Event', []string{}, &this),
	])
	var_args.array_unset(rt.new_string('_rt'))
	var_args.array_unset(rt.new_string('_'))
	mut var_validated := Class_WC_Tracks_Event.validate_and_sanitize(var_args.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_validated.clone()])) {
		return ''
	}
	return (rt.call_function('esc_url_raw', [
		rt.new_string((Class_WC_Tracks_Client.pixel()).str() + '?' +
			(rt.call_function('http_build_query', [var_validated.clone()])).str()),
	])).str()
}

fn Class_WC_Tracks_Event.sanitize_property_values(var_properties rt.PhpVal) rt.PhpVal {
	mut var_is_object := rt.new_bool(var_properties.clone().is_object())
	mut var_props := if rt.is_true(var_is_object) { rt.call_function('get_object_vars', [
			var_properties.clone(),
		]) } else { var_properties }
	mut iter_3 := var_props.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if !(var_value.clone().is_array()) {
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
			var_props.array_set(var_key, '')
			continue
		}
		mut var_is_indexed_array := rt.identical(rt.func_array_keys(var_value.clone()), rt.call_function('range', [
			rt.new_int(0),
			rt.new_int(var_value.clone().array_count() - 1),
		]))
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(var_item.clone().is_array() || var_item.clone().is_object())
		}
		mut var_has_scalar_only := rt.new_bool(!(rt.is_true(rt.call_function('array_filter', [
			var_value.clone(),
			rt.new_closure(closure_6_fn),
		]))))
		if rt.is_true(var_is_indexed_array) && rt.is_true(var_has_scalar_only) {
			var_props.array_set(var_key, rt.call_function('implode', [
				rt.new_string(','),
				rt.call_function('array_map', [
					rt.new_string('strval'),
					var_value.clone(),
				])]))
			continue
		}
		mut var_encoded := rt.call_function('wp_json_encode', [
			var_value.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))])
		var_props.array_set(var_key, if rt.is_true(rt.identical(rt.new_bool(false), var_encoded)) {
			rt.new_string('')
		} else {
			var_encoded
		})
	}
	return if rt.is_true(var_is_object) { rt.array_to_object(var_props) } else { var_props }
}

fn Class_WC_Tracks_Event.event_name_is_valid(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_match', [
		rt.new_string(Class_WC_Tracks_Event.event_name_regex()),
		var_name.clone(),
	])
}

fn Class_WC_Tracks_Event.prop_name_is_valid(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_match', [
		rt.new_string(Class_WC_Tracks_Event.prop_name_regex()),
		var_name.clone(),
	])
}

fn Class_WC_Tracks_Event.scrutinize_event_names(var_event rt.PhpVal) {
	mut var_event_mutated := var_event
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.event_name_is_valid(rt.get_property(var_event_mutated,
		'_en'))))))
	{
		return
	}
	mut var_allowed_key_names := ['anonId', 'Browser_Type']
	mut iter_4 := rt.func_array_keys(rt.cast_array(var_event_mutated)).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_key := item_4.val
		if rt.is_true(rt.call_function('in_array', [var_key.clone(),
			rt.create_array_from_list(var_allowed_key_names),
			rt.new_bool(true)]))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.prop_name_is_valid(var_key.clone()))))) {
			return
		}
	}
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Client {
	rt.PhpObjectBase
}

struct Class_WC_Tracks_Footer_Pixel {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_tracks_event(arg_0 rt.PhpVal) &Class_WC_Tracks_Event {
	mut obj := &Class_WC_Tracks_Event{
		PhpObjectBase: rt.PhpObjectBase{}
		error:         rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
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

fn create_wc_tracks_footer_pixel(_args ...rt.PhpVal) &Class_WC_Tracks_Footer_Pixel {
	mut obj := &Class_WC_Tracks_Footer_Pixel{
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

fn (mut this Class_WC_Tracks_Event) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'record' {
			return this.record()
		}
		'validate_and_sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Event.validate_and_sanitize(dispatch_arg_0)
		}
		'build_pixel_url' {
			return rt.new_string(this.build_pixel_url())
		}
		'sanitize_property_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Event.sanitize_property_values(dispatch_arg_0)
		}
		'event_name_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Event.event_name_is_valid(dispatch_arg_0)
		}
		'prop_name_is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Tracks_Event.prop_name_is_valid(dispatch_arg_0)
		}
		'scrutinize_event_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Tracks_Event.scrutinize_event_names(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Tracks_Event) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Tracks_Event) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_WC_Tracks_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Tracks_Footer_Pixel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tracks_Footer_Pixel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tracks_Footer_Pixel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
