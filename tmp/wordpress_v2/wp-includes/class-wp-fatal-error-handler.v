import rt

struct Class_WP_Fatal_Error_Handler {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Fatal_Error_Handler) handle() {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_SANDBOX_SCRAPING')]))
		&& rt.is_true(rt.get_constant('WP_SANDBOX_SCRAPING')) {
		return
	}
	if rt.is_true(rt.call_function('wp_is_maintenance_mode', []rt.PhpVal{})) {
		return
	}
	mut var_error := this.detect_error()
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_error)))) {
		return
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !(var_GLOBALS.array_isset(rt.new_string('wp_locale')))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('load_default_textdomain')])) {
		rt.call_function('load_default_textdomain', []rt.PhpVal{})
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
	mut var_handled := rt.new_bool(false)
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}), 'is_initialized', []rt.PhpVal{})) {
		var_handled = rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}),
			'handle_error', [var_error.clone()])
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
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		this.display_error_template(var_error.clone(), var_handled.clone())
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

fn (mut this Class_WP_Fatal_Error_Handler) detect_error() rt.PhpVal {
	mut var_error := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_null(), var_error)) {
		return rt.new_null()
	}
	if !(this.should_handle_error(var_error.clone())) {
		return rt.new_null()
	}
	return var_error.clone()
}

fn (mut this Class_WP_Fatal_Error_Handler) should_handle_error(var_error rt.PhpVal) bool {
	mut var_error_mutated := var_error
	mut var_error_types_to_handle := [rt.get_constant('E_ERROR'),
		rt.get_constant('E_PARSE'), rt.get_constant('E_USER_ERROR'),
		rt.get_constant('E_COMPILE_ERROR'), rt.get_constant('E_RECOVERABLE_ERROR')]
	if var_error_mutated.array_isset(rt.new_string('type'))
		&& rt.is_true(rt.call_function('in_array', [var_error_mutated.array_get(rt.new_string('type')), rt.create_array_from_list(var_error_types_to_handle), rt.new_bool(true)])) {
		return true
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('wp_should_handle_php_error'),
		rt.new_bool(false),
		var_error_mutated.clone(),
	])).to_bool()
}

fn (mut this Class_WP_Fatal_Error_Handler) display_error_template(var_error rt.PhpVal, var_handled rt.PhpVal) {
	mut var_error_mutated := var_error
	mut var_handled_mutated := var_handled
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')])) {
		mut var_php_error_pluggable := rt.new_string(
			(rt.get_constant('WP_CONTENT_DIR')).str() + '/php-error.php')
		if rt.is_true(rt.call_function('is_readable', [var_php_error_pluggable.clone()])) {
			rt.include_file(var_php_error_pluggable.to_string(), '4')
			return
		}
	}
	this.display_default_error_template(var_error_mutated.clone(), var_handled_mutated.clone())
}

fn (mut this Class_WP_Fatal_Error_Handler) display_default_error_template(var_error rt.PhpVal, var_handled rt.PhpVal) {
	mut var_error_mutated := var_error
	mut var_handled_mutated := var_handled
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('__'),
	])))))
	{
		rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_die'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/functions.php',
			'4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Error'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-error.php',
			'4')
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_handled_mutated))
		&& rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
		mut var_message := rt.call_function('__', [
			rt.new_string('There has been a critical error on this website, putting it in recovery mode. Please check the Themes and Plugins screens for more details. If you just installed or updated a theme or plugin, check the relevant page for that first.'),
		])
	} else if rt.is_true(rt.call_function('is_protected_endpoint', []rt.PhpVal{}))
		&& rt.is_true(rt.call_method(rt.call_function('wp_recovery_mode', []rt.PhpVal{}), 'is_initialized', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			var_message = rt.call_function('__', [
				rt.new_string('There has been a critical error on this website. Please reach out to your site administrator, and inform them of this error for further assistance.'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('There has been a critical error on this website. Please check your site admin email inbox for instructions. If you continue to have problems, please try the <a href="%s">support forums</a>.'),
				]),
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			])
		}
	} else {
		var_message = rt.call_function('__', [
			rt.new_string('There has been a critical error on this website.'),
		])
	}
	var_message = rt.call_function('sprintf', [
		rt.new_string('<p>%s</p><p><a href="%s">%s</a></p>'),
		var_message.clone(),
		rt.call_function('__', [
			rt.new_string('https://wordpress.org/documentation/article/faq-troubleshooting/'),
		]),
		rt.call_function('__', [
			rt.new_string('Learn more about troubleshooting WordPress.'),
		]),
	])
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'response', val: 500 },
		rt.ArrayItem{ key: 'exit', val: false }])
	var_message = rt.call_function('apply_filters', [
		rt.new_string('wp_php_error_message'),
		var_message.clone(),
		var_error_mutated.clone(),
	])
	var_args = rt.call_function('apply_filters', [rt.new_string('wp_php_error_args'),
		var_args.clone(), var_error_mutated.clone()])
	mut var_wp_error := create_wp_error(rt.new_string('internal_server_error'),
		var_message.clone(), rt.create_array([
		rt.ArrayItem{ key: 'error', val: var_error_mutated },
	]))
	rt.call_function('wp_die', [var_wp_error, rt.new_string(''),
		var_args.clone()])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_fatal_error_handler(_args ...rt.PhpVal) &Class_WP_Fatal_Error_Handler {
	mut obj := &Class_WP_Fatal_Error_Handler{
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

fn (mut this Class_WP_Fatal_Error_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'handle' {
			this.handle()
			return rt.new_null()
		}
		'detect_error' {
			return this.detect_error()
		}
		'should_handle_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.should_handle_error(dispatch_arg_0))
		}
		'display_error_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_error_template(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display_default_error_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.display_default_error_template(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Fatal_Error_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Fatal_Error_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
