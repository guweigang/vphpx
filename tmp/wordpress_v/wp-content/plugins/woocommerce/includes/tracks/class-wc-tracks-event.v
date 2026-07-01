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

fn (mut this Class_WC_Tracks_Event) construct(var_event rt.PhpVal)  {
	mut var_event_mutated := var_event
	mut var__event := Class_WC_Tracks_Event.validate_and_sanitize(var_event_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var__event.dup()])) {
		this.error = var__event.dup()
		return
	}
	{
		mut iter_1 := var__event.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":48,"name":"key"}', var_value.dup())
		}
	}
}

fn (mut this Class_WC_Tracks_Event) record() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('REST_REQUEST'))))) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.is_true(arg_0) }(rt.new_string('WP_CLI'))))) || rt.is_true(rt.call_function('wp_doing_cron', []rt.PhpVal{})))) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks_Client{}; return temp.record_event(arg_0) }(rt.new_object('WC_Tracks_Event', []string{}, this))
	}
	return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tracks_Footer_Pixel{}; return temp.record_event(arg_0) }(rt.new_object('WC_Tracks_Event', []string{}, this))
}

fn Class_WC_Tracks_Event.validate_and_sanitize(var_event rt.PhpVal) rt.PhpVal {
	mut var_event_mutated := var_event
	var_event_mutated = // unsupported expression: Expr_Cast_Object
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_event_mutated, '_en'))))) {
		return create_wp_error(rt.new_string('invalid_event'), rt.new_string('A valid event must be specified via `_en`'), rt.new_int(400))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_event_mutated.dup(), rt.new_string('_via_ip')])) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^192\\.168|^10\\./'), rt.get_property(var_event_mutated, '_via_ip')])))) {
		rt.get_property(var_event_mutated, '_via_ip') = rt.new_null()
	}
	mut var_validated := rt.create_array([rt.ArrayItem{ key: 'browser_type', val: Class_WC_Tracks_Client.browser_type() }])
	mut var__event := // unsupported expression: Expr_Cast_Object
	if !(!(rt.get_property(var__event, '_ts')).is_null()) {
		rt.set_property(var__event, '_ts', fn () rt.PhpVal { mut temp := Class_WC_Tracks_Client{}; return temp.build_timestamp() }())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.event_name_is_valid(rt.get_property(var__event, '_en')))))) {
		return create_wp_error(rt.new_string('invalid_event_name'), rt.call_function('__', [rt.new_string('A valid event name must be specified.'), rt.new_string('woocommerce')]))
	}
	{
		mut iter_1 := rt.func_array_keys(rt.cast_array(var__event)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.prop_name_is_valid(var_key.dup()))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				return create_wp_error(rt.new_string('invalid_prop_name'), rt.call_function('__', [rt.new_string('A valid prop name must be specified'), rt.new_string('woocommerce')]))
			}
		}
	}
	var__event = Class_WC_Tracks_Event.sanitize_property_values(var__event.dup())
	return var__event.dup()
}

fn (mut this Class_WC_Tracks_Event) build_pixel_url() string {
	if rt.is_true(this.error) {
		return ''
	}
	mut var_args := rt.call_function('get_object_vars', [rt.new_object('WC_Tracks_Event', []string{}, &this)])
	var_args.array_unset(rt.new_string('_rt'))
	var_args.array_unset(rt.new_string('_'))
	mut var_validated := Class_WC_Tracks_Event.validate_and_sanitize(var_args.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_validated.dup()])) {
		return ''
	}
	return (rt.call_function('esc_url_raw', [(Class_WC_Tracks_Client.pixel()).str() + '?' + (rt.call_function('http_build_query', [var_validated.dup()])).str()])).str()
}

fn Class_WC_Tracks_Event.sanitize_property_values(var_properties rt.PhpVal) rt.PhpVal {
	mut var_is_object := rt.new_bool(rt.new_bool(var_properties.dup().is_object()))
	mut var_props := if rt.is_true(var_is_object) { rt.call_function('get_object_vars', [var_properties.dup()]) } else { var_properties }
	{
		mut iter_1 := var_props.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_value)))) {
				var_props.array_set(var_key, '')
				continue
			}
			mut var_is_indexed_array := rt.identical(rt.func_array_keys(var_value.dup()), rt.call_function('range', [rt.new_int(0), var_value.dup().array_count() - 1]))
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.new_bool(var_item.dup().is_array())) || rt.is_true(rt.new_bool(var_item.dup().is_object())))
	}
			mut var_has_scalar_only := rt.new_bool(rt.new_bool(!(rt.is_true(rt.call_function('array_filter', [var_value.dup(), rt.new_closure(closure_1_fn)])))))
			if rt.is_true(rt.new_bool(rt.is_true(var_is_indexed_array) && rt.is_true(var_has_scalar_only))) {
				var_props.array_set(var_key, rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('strval'), var_value.dup()])]))
				continue
			}
			mut var_encoded := rt.call_function('wp_json_encode', [var_value.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])
			var_props.array_set(var_key, if rt.is_true(rt.identical(rt.new_bool(false), var_encoded)) { rt.new_string('') } else { var_encoded })
		}
	}
	return if rt.is_true(var_is_object) { // unsupported expression: Expr_Cast_Object } else { var_props }
}

fn Class_WC_Tracks_Event.event_name_is_valid(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_match', [Class_WC_Tracks_Event.event_name_regex(), var_name.dup()])
}

fn Class_WC_Tracks_Event.prop_name_is_valid(var_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('preg_match', [Class_WC_Tracks_Event.prop_name_regex(), var_name.dup()])
}

fn Class_WC_Tracks_Event.scrutinize_event_names(var_event rt.PhpVal)  {
	mut var_event_mutated := var_event
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.event_name_is_valid(rt.get_property(var_event_mutated, '_en')))))) {
		return rt.new_null()
	}
	mut var_allowed_key_names := ['anonId', 'Browser_Type']
	{
		mut iter_1 := rt.func_array_keys(rt.cast_array(var_event_mutated)).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_key.dup(), var_allowed_key_names.dup(), rt.new_bool(true)])) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Tracks_Event.prop_name_is_valid(var_key.dup()))))) {
				return rt.new_null()
			}
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
		error: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_client() &Class_WC_Tracks_Client {
	mut obj := &Class_WC_Tracks_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tracks_footer_pixel() &Class_WC_Tracks_Footer_Pixel {
	mut obj := &Class_WC_Tracks_Footer_Pixel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
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
		else { return none }
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
		'error' { this.error = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_includes_tracks_class_wc_tracks_event_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
