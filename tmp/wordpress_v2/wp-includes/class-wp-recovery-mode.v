import rt

pub fn Class_WP_Recovery_Mode.exit_action() string {
	return 'exit_recovery_mode'
}

struct Class_WP_Recovery_Mode {
	rt.PhpObjectBase
pub mut:
	cookie_service rt.PhpVal = rt.new_null()
	key_service    rt.PhpVal = rt.new_null()
	link_service   rt.PhpVal = rt.new_null()
	email_service  rt.PhpVal = rt.new_null()
	is_initialized bool
	is_active      bool
	session_id     rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Recovery_Mode) construct() {
	this.cookie_service = create_wp_recovery_mode_cookie_service()
	this.key_service = create_wp_recovery_mode_key_service()
	this.link_service = create_wp_recovery_mode_link_service(this.cookie_service, this.key_service)
	this.email_service = create_wp_recovery_mode_email_service(this.link_service)
}

fn (mut this Class_WP_Recovery_Mode) initialize() {
	this.is_initialized = true
	rt.call_function('add_action', [rt.new_string('wp_logout'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Recovery_Mode', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'exit_recovery_mode' },
		])])
	rt.call_function('add_action', [
		rt.new_string('login_form_' + Class_WP_Recovery_Mode.exit_action()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Recovery_Mode', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_exit_recovery_mode' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('recovery_mode_clean_expired_keys'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Recovery_Mode', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'clean_expired_keys' },
		])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('recovery_mode_clean_expired_keys')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('daily'), rt.new_string('recovery_mode_clean_expired_keys')])
	}
	if rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_RECOVERY_MODE_SESSION_ID'),
	]))
	{
		this.is_active = true
		this.session_id = rt.get_constant('WP_RECOVERY_MODE_SESSION_ID')
		return
	}
	if rt.is_true(rt.call_method(this.cookie_service, 'is_cookie_set', []rt.PhpVal{})) {
		this.handle_cookie()
		return
	}
	rt.call_method(this.link_service, 'handle_begin_link', [this.get_link_ttl()])
}

fn (mut this Class_WP_Recovery_Mode) is_active() bool {
	return this.is_active
}

fn (mut this Class_WP_Recovery_Mode) get_session_id() rt.PhpVal {
	return this.session_id
}

fn (mut this Class_WP_Recovery_Mode) is_initialized() bool {
	return this.is_initialized
}

fn (mut this Class_WP_Recovery_Mode) handle_error(mut var_error Class_array) bool {
	mut var_extension := this.get_extension_for_error(rt.new_object('array', []string{}, var_error))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension))))
		|| this.is_network_plugin(var_extension.clone()) {
		return (create_wp_error(rt.new_string('invalid_source'), rt.call_function('__', [
			rt.new_string('Error not caused by a plugin or theme.'),
		]))).to_bool()
	}
	if !(this.is_active()) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_protected_endpoint',
			[]rt.PhpVal{})))))
		{
			return (create_wp_error(rt.new_string('non_protected_endpoint'), rt.call_function('__', [
				rt.new_string('Error occurred on a non-protected endpoint.'),
			]))).to_bool()
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wp_generate_password'),
		])))))
		{
			rt.include_file(
				(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php',
				'4')
		}
		return (rt.call_method(this.email_service, 'maybe_send_recovery_mode_email', [
			this.get_email_rate_limit(),
			var_error,
			var_extension.clone(),
		])).to_bool()
	}
	if !(this.store_error(rt.new_object('array', []string{}, var_error))) {
		return (create_wp_error(rt.new_string('storage_error'), rt.call_function('__', [
			rt.new_string('Failed to store the error.'),
		]))).to_bool()
	}
	if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) {
		return true
	}
	this.redirect_protected()
	return false
}

fn (mut this Class_WP_Recovery_Mode) exit_recovery_mode() bool {
	if !(this.is_active()) {
		return false
	}
	rt.call_method(this.email_service, 'clear_rate_limit', []rt.PhpVal{})
	rt.call_method(this.cookie_service, 'clear_cookie', []rt.PhpVal{})
	rt.call_method(rt.call_function('wp_paused_plugins', []rt.PhpVal{}), 'delete_all',
		[]rt.PhpVal{})
	rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}), 'delete_all', []rt.PhpVal{})
	return true
}

fn (mut this Class_WP_Recovery_Mode) handle_exit_recovery_mode() {
	mut var_redirect_to := rt.call_function('wp_get_referer', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_redirect_to)))) {
		var_redirect_to = if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			rt.call_function('admin_url', []rt.PhpVal{})
		} else {
			rt.call_function('home_url', []rt.PhpVal{})
		}
	}
	if !(this.is_active()) {
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
		exit(0)
	}
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('action')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_Recovery_Mode.exit_action(), rt.get_superglobal('_GET').array_get(rt.new_string('action')))))) {
		return
	}
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')), rt.new_string(Class_WP_Recovery_Mode.exit_action())]))))) {
		rt.call_function('wp_die', [
			rt.call_function('__', [rt.new_string('Exit recovery mode link expired.')]),
			rt.new_int(403),
		])
	}
	if !(this.exit_recovery_mode()) {
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Failed to exit recovery mode. Please try again later.'),
			]),
		])
	}
	rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
	exit(0)
}

fn (mut this Class_WP_Recovery_Mode) clean_expired_keys() {
	rt.call_method(this.key_service, 'clean_expired_keys', [this.get_link_ttl()])
}

fn (mut this Class_WP_Recovery_Mode) handle_cookie() {
	mut var_validated := rt.call_method(this.cookie_service, 'validate_cookie', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_validated.clone()])) {
		rt.call_method(this.cookie_service, 'clear_cookie', []rt.PhpVal{})
		rt.call_method(var_validated, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]),
		])
		rt.call_function('wp_die', [var_validated.clone()])
	}
	mut var_session_id := rt.call_method(this.cookie_service, 'get_session_id_from_cookie',
		[]rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_session_id.clone()])) {
		rt.call_method(this.cookie_service, 'clear_cookie', []rt.PhpVal{})
		rt.call_method(var_session_id, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 403 }]),
		])
		rt.call_function('wp_die', [var_session_id.clone()])
	}
	this.is_active = true
	this.session_id = var_session_id.clone()
}

fn (mut this Class_WP_Recovery_Mode) get_email_rate_limit() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('recovery_mode_email_rate_limit'),
		rt.get_constant('DAY_IN_SECONDS'),
	])
}

fn (mut this Class_WP_Recovery_Mode) get_link_ttl() rt.PhpVal {
	mut var_rate_limit := this.get_email_rate_limit()
	mut var_valid_for := var_rate_limit.clone()
	var_valid_for = rt.call_function('apply_filters', [
		rt.new_string('recovery_mode_email_link_ttl'),
		var_valid_for.clone(),
	])
	return rt.call_function('max', [var_valid_for.clone(), var_rate_limit.clone()])
}

fn (mut this Class_WP_Recovery_Mode) get_extension_for_error(var_error rt.PhpVal) rt.PhpVal {
	mut var_wp_theme_directories := rt.new_null()
	if !(var_error.array_isset(rt.new_string('file'))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_PLUGIN_DIR'),
	])))))
	{
		return rt.new_bool(false)
	}
	mut var_error_file := rt.call_function('wp_normalize_path', [
		var_error.array_get(rt.new_string('file')),
	])
	mut var_wp_plugin_dir := rt.call_function('wp_normalize_path', [
		rt.get_constant('WP_PLUGIN_DIR'),
	])
	if rt.is_true(rt.call_function('str_starts_with', [var_error_file.clone(),
		var_wp_plugin_dir.clone()]))
	{
		mut var_path := rt.call_function('str_replace', [
			rt.new_string(var_wp_plugin_dir.str() + '/'),
			rt.new_string(''),
			var_error_file.clone(),
		])
		mut var_parts := rt.call_function('explode', [rt.new_string('/'),
			var_path.clone()])
		return rt.create_array([rt.ArrayItem{ key: 'type', val: 'plugin' },
			rt.ArrayItem{ key: 'slug', val: var_parts.array_get(rt.new_int(0)) }])
	}
	if !rt.is_true(var_wp_theme_directories) {
		return rt.new_bool(false)
	}
	mut iter_1 := var_wp_theme_directories.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_theme_directory := item_1.val
		var_theme_directory = rt.call_function('wp_normalize_path', [
			var_theme_directory.clone()])
		if rt.is_true(rt.call_function('str_starts_with', [var_error_file.clone(),
			var_theme_directory.clone()]))
		{
			var_path = rt.call_function('str_replace', [
				rt.new_string(var_theme_directory.str() + '/'),
				rt.new_string(''),
				var_error_file.clone(),
			])
			var_parts = rt.call_function('explode', [rt.new_string('/'),
				var_path.clone()])
			return rt.create_array([rt.ArrayItem{ key: 'type', val: 'theme' },
				rt.ArrayItem{ key: 'slug', val: var_parts.array_get(rt.new_int(0)) }])
		}
	}
	return rt.new_bool(false)
}

fn (mut this Class_WP_Recovery_Mode) is_network_plugin(var_extension rt.PhpVal) bool {
	mut var_extension_mutated := var_extension
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugin'),
		var_extension_mutated.array_get(rt.new_string('type'))))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return false
	}
	mut var_network_plugins := rt.call_function('wp_get_active_network_plugins', []rt.PhpVal{})
	mut iter_2 := var_network_plugins.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin := item_2.val
		if rt.is_true(rt.call_function('str_starts_with', [var_plugin.clone(),
			rt.new_string((var_extension_mutated.array_get(rt.new_string('slug'))).str() + '/')]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Recovery_Mode) store_error(var_error rt.PhpVal) bool {
	mut var_extension := this.get_extension_for_error(var_error.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension)))) {
		return false
	}
	mut switch_val_1 := var_extension.array_get(rt.new_string('type'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('plugin'))) {
		return (rt.call_method(rt.call_function('wp_paused_plugins', []rt.PhpVal{}), 'set', [
			var_extension.array_get(rt.new_string('slug')),
			var_error.clone(),
		])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme'))) {
		return (rt.call_method(rt.call_function('wp_paused_themes', []rt.PhpVal{}), 'set', [
			var_extension.array_get(rt.new_string('slug')),
			var_error.clone(),
		])).to_bool()
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_Recovery_Mode) redirect_protected() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_safe_redirect'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/pluggable.php',
			'4')
	}
	mut var_scheme := rt.new_string((if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
		'https://'
	} else {
		'http://'
	}).str())
	mut var_url := rt.new_string((rt.concat(rt.concat(var_scheme,
		rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))),
		rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI')))).str())
	rt.call_function('wp_safe_redirect', [var_url.clone()])
	exit(0)
}

struct Class_WP_Recovery_Mode_Cookie_Service {
	rt.PhpObjectBase
}

struct Class_WP_Recovery_Mode_Key_Service {
	rt.PhpObjectBase
}

struct Class_WP_Recovery_Mode_Link_Service {
	rt.PhpObjectBase
}

struct Class_WP_Recovery_Mode_Email_Service {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_recovery_mode() &Class_WP_Recovery_Mode {
	mut obj := &Class_WP_Recovery_Mode{
		PhpObjectBase:  rt.PhpObjectBase{}
		cookie_service: rt.new_null()
		key_service:    rt.new_null()
		link_service:   rt.new_null()
		email_service:  rt.new_null()
		is_initialized: false
		is_active:      false
		session_id:     rt.new_string('')
	}
	obj.construct()
	return obj
}

fn create_wp_recovery_mode_cookie_service(_args ...rt.PhpVal) &Class_WP_Recovery_Mode_Cookie_Service {
	mut obj := &Class_WP_Recovery_Mode_Cookie_Service{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_recovery_mode_key_service(_args ...rt.PhpVal) &Class_WP_Recovery_Mode_Key_Service {
	mut obj := &Class_WP_Recovery_Mode_Key_Service{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_recovery_mode_link_service(_args ...rt.PhpVal) &Class_WP_Recovery_Mode_Link_Service {
	mut obj := &Class_WP_Recovery_Mode_Link_Service{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_recovery_mode_email_service(_args ...rt.PhpVal) &Class_WP_Recovery_Mode_Email_Service {
	mut obj := &Class_WP_Recovery_Mode_Email_Service{
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

fn (mut this Class_WP_Recovery_Mode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'is_active' {
			return rt.new_bool(this.is_active())
		}
		'get_session_id' {
			return this.get_session_id()
		}
		'is_initialized' {
			return rt.new_bool(this.is_initialized())
		}
		'handle_error' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.handle_error(mut dispatch_arg_0))
		}
		'exit_recovery_mode' {
			return rt.new_bool(this.exit_recovery_mode())
		}
		'handle_exit_recovery_mode' {
			this.handle_exit_recovery_mode()
			return rt.new_null()
		}
		'clean_expired_keys' {
			this.clean_expired_keys()
			return rt.new_null()
		}
		'handle_cookie' {
			this.handle_cookie()
			return rt.new_null()
		}
		'get_email_rate_limit' {
			return this.get_email_rate_limit()
		}
		'get_link_ttl' {
			return this.get_link_ttl()
		}
		'get_extension_for_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_extension_for_error(dispatch_arg_0)
		}
		'is_network_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_network_plugin(dispatch_arg_0))
		}
		'store_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.store_error(dispatch_arg_0))
		}
		'redirect_protected' {
			this.redirect_protected()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Recovery_Mode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cookie_service' { return this.cookie_service }
		'key_service' { return this.key_service }
		'link_service' { return this.link_service }
		'email_service' { return this.email_service }
		'is_initialized' { return rt.new_bool(this.is_initialized) }
		'is_active' { return rt.new_bool(this.is_active) }
		'session_id' { return this.session_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Recovery_Mode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cookie_service' {
			this.cookie_service = val
			return true
		}
		'key_service' {
			this.key_service = val
			return true
		}
		'link_service' {
			this.link_service = val
			return true
		}
		'email_service' {
			this.email_service = val
			return true
		}
		'is_initialized' {
			this.is_initialized = val.to_bool()
			return true
		}
		'is_active' {
			this.is_active = val.to_bool()
			return true
		}
		'session_id' {
			this.session_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Recovery_Mode_Cookie_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode_Cookie_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Recovery_Mode_Key_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode_Key_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Recovery_Mode_Link_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode_Link_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Recovery_Mode_Email_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
