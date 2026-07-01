import rt

fn wp_paused_plugins() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(rt.new_null(), var_storage)) {
		mut var_storage := create_wp_paused_extensions_storage(rt.new_string('plugin'))
	}
	return mut var_storage
}

fn wp_paused_themes() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.identical(rt.new_null(), var_storage)) {
		mut var_storage := create_wp_paused_extensions_storage(rt.new_string('theme'))
	}
	return mut var_storage
}

fn wp_get_extension_error_description(var_error rt.PhpVal) rt.PhpVal {
	mut var_constants := rt.call_function('get_defined_constants', [
		rt.new_bool(true)])
	var_constants = if !(var_constants.array_get('Core')).is_null() {
		var_constants.array_get('Core')
	} else {
		var_constants.array_get('internal')
	}
	mut var_core_errors := rt.new_array()
	{
		mut iter_1 := var_constants.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_constant := item_1.key
			if rt.is_true(rt.call_function('str_starts_with', [
				var_constant.dup(), rt.new_string('E_')]))
			{
				var_core_errors.array_set(var_value, var_constant.dup())
			}
		}
	}
	if var_core_errors.array_isset(var_error.array_get('type')) {
		var_error['type'] = var_core_errors.array_get(var_error.array_get('type'))
	}
	mut var_error_message := rt.call_function('__', [
		rt.new_string('An error of type %1$s was caused in line %2$s of the file %3$s. Error message: %4$s'),
	])
	return rt.call_function('sprintf', [var_error_message.dup(),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get('type')),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get('line')),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get('file')),
			rt.new_string('</code>')),
		rt.concat(rt.concat(rt.new_string('<code>'), var_error.array_get('message')),
			rt.new_string('</code>'))])
}

fn wp_register_fatal_error_handler() {
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_is_fatal_error_handler_enabled())))) {
		return rt.new_null()
	}
	mut var_handler := rt.new_null()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')]))
		&& rt.is_true(rt.call_function('is_readable', [(rt.get_constant('WP_CONTENT_DIR')).str() + '/fatal-error-handler.php']))))
	{
		var_handler = rt.include_file(
			(rt.get_constant('WP_CONTENT_DIR')).str() + '/fatal-error-handler.php', '1')
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_handler.dup().is_object())))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
		key: none
		val: var_handler
	}, rt.ArrayItem{ key: none, val: 'handle' }])])))))))
	{
		var_handler = create_wp_fatal_error_handler()
	}
	rt.call_function('register_shutdown_function', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_handler },
			rt.ArrayItem{ key: none, val: 'handle' }]),
	])
}

fn wp_is_fatal_error_handler_enabled() rt.PhpVal {
	mut var_enabled :=
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_DISABLE_FATAL_ERROR_HANDLER')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_DISABLE_FATAL_ERROR_HANDLER')))))
	return rt.call_function('apply_filters', [
		rt.new_string('wp_fatal_error_handler_enabled'),
		rt.new_bool(var_enabled).dup(),
	])
}

fn wp_recovery_mode() rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_recovery_mode)))) {
		mut var_wp_recovery_mode := create_wp_recovery_mode()
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

fn create_wp_paused_extensions_storage() &Class_WP_Paused_Extensions_Storage {
	mut obj := &Class_WP_Paused_Extensions_Storage{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_fatal_error_handler() &Class_WP_Fatal_Error_Handler {
	mut obj := &Class_WP_Fatal_Error_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_recovery_mode() &Class_WP_Recovery_Mode {
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

pub fn init_wp_includes_error_protection_php() {
}
