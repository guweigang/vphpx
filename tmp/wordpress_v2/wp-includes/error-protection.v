import rt

fn wp_paused_plugins() rt.PhpVal {
	mut var_storage := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_storage)) {
		var_storage = create_wp_paused_extensions_storage(rt.new_string('plugin'))
	}
	return mut var_storage
}

fn wp_paused_themes() rt.PhpVal {
	mut var_storage := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_storage)) {
		var_storage = create_wp_paused_extensions_storage(rt.new_string('theme'))
	}
	return mut var_storage
}

fn wp_get_extension_error_description(var_error rt.PhpVal) rt.PhpVal {
	mut var_constants := rt.new_null()
	mut var_core_errors := rt.new_null()
	mut var_value := rt.new_null()
	mut var_constant := rt.new_null()
	mut var_error_message := rt.new_null()
	var_constants = rt.call_function('get_defined_constants', [
		rt.new_bool(true)])
	var_constants = if !(var_constants.array_get(rt.new_string('Core'))).is_null() {
		var_constants.array_get(rt.new_string('Core'))
	} else {
		var_constants.array_get(rt.new_string('internal'))
	}
	var_core_errors = rt.new_array()
	mut iter_1 := var_constants.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_constant_shadow := item_1.key
		if rt.is_true(rt.call_function('str_starts_with', [var_constant_shadow.clone(),
			rt.new_string('E_')]))
		{
			var_core_errors.array_set(var_value_shadow, var_constant_shadow.clone())
		}
	}
	if var_core_errors.array_isset(var_error.array_get(rt.new_string('type'))) {
		var_error['type'] = var_core_errors.array_get(var_error.array_get(rt.new_string('type')))
	}
	var_error_message = rt.call_function('__', [
		rt.new_string('An error of type %1$s was caused in line %2$s of the file %3$s. Error message: %4$s'),
	])
	return rt.call_function('sprintf', [var_error_message.clone(),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get(rt.new_string('type'))),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get(rt.new_string('line'))),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get(rt.new_string('file'))),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get(rt.new_string('message'))),
			rt.new_string('</code>'))])
}

fn wp_register_fatal_error_handler() {
	mut var_handler := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_fatal_error_handler_enabled())))) {
		return
	}
	var_handler = rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')]))
		&& rt.is_true(rt.call_function('is_readable', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/fatal-error-handler.php')])) {
		var_handler = rt.include_file(
			(rt.get_constant('WP_CONTENT_DIR')).str() + '/fatal-error-handler.php', '1')
	}
	if !(var_handler.clone().is_object())
		|| !(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_handler
	}, rt.ArrayItem{ key: none, val: 'handle' }])])) {
		var_handler = create_wp_fatal_error_handler()
	}
	rt.call_function('register_shutdown_function', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_handler },
			rt.ArrayItem{ key: none, val: 'handle' }]),
	])
}

fn wp_is_fatal_error_handler_enabled() rt.PhpVal {
	mut var_enabled := false
	var_enabled =
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DISABLE_FATAL_ERROR_HANDLER')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DISABLE_FATAL_ERROR_HANDLER')))))
	return rt.call_function('apply_filters', [
		rt.new_string('wp_fatal_error_handler_enabled'),
		rt.new_bool(var_enabled).clone(),
	])
}

fn wp_recovery_mode() rt.PhpVal {
	mut var_wp_recovery_mode := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_recovery_mode)))) {
		var_wp_recovery_mode = create_wp_recovery_mode()
	}
	return mut var_wp_recovery_mode
}

struct Class_WP_Paused_Extensions_Storage {
	rt.PhpObjectBase
}

struct Class_WP_Fatal_Error_Handler {
	rt.PhpObjectBase
}

struct Class_WP_Recovery_Mode {
	rt.PhpObjectBase
}

fn create_wp_paused_extensions_storage(_args ...rt.PhpVal) &Class_WP_Paused_Extensions_Storage {
	mut obj := &Class_WP_Paused_Extensions_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_fatal_error_handler(_args ...rt.PhpVal) &Class_WP_Fatal_Error_Handler {
	mut obj := &Class_WP_Fatal_Error_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_recovery_mode(_args ...rt.PhpVal) &Class_WP_Recovery_Mode {
	mut obj := &Class_WP_Recovery_Mode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Paused_Extensions_Storage) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Paused_Extensions_Storage) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Paused_Extensions_Storage) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Fatal_Error_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Fatal_Error_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Fatal_Error_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Recovery_Mode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Recovery_Mode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
