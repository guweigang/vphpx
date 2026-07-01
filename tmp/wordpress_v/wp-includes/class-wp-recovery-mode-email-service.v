import rt

pub fn Class_WP_Recovery_Mode_Email_Service.rate_limit_option() string {
	return 'recovery_mode_email_last_sent'
}

struct Class_WP_Recovery_Mode_Email_Service {
	rt.PhpObjectBase
pub mut:
	link_service rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) construct(mut var_link_service Class_WP_Recovery_Mode_Link_Service) {
	this.link_service = var_link_service.dup()
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) maybe_send_recovery_mode_email(var_rate_limit rt.PhpVal, var_error rt.PhpVal, var_extension rt.PhpVal) bool {
	mut var_last_sent := rt.call_function('get_option', [
		Class_WP_Recovery_Mode_Email_Service.rate_limit_option(),
	])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_last_sent))))
		|| rt.is_true(rt.greater(rt.call_function('time', []rt.PhpVal{}), rt.add(var_last_sent, var_rate_limit)))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('update_option', [
			Class_WP_Recovery_Mode_Email_Service.rate_limit_option(),
			rt.call_function('time', []rt.PhpVal{}),
		])))))
		{
			return (create_wp_error(rt.new_string('storage_error'), rt.call_function('__', [
				rt.new_string('Could not update the email last sent time.'),
			]))).to_bool()
		}
		mut var_sent := this.send_recovery_mode_email(var_rate_limit.dup(), var_error.dup(),
			var_extension.dup())
		if rt.is_true(var_sent) {
			return true
		}
		return (create_wp_error(rt.new_string('email_failed'), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The email could not be sent. Possible reason: your host may have disabled the %s function.'),
			]),
			rt.new_string('mail()'),
		]))).to_bool()
	}
	mut var_err_message := rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('A recovery link was already sent %1$s ago. Please wait another %2$s before requesting a new email.'),
		]),
		rt.call_function('human_time_diff', [
			var_last_sent.dup(),
		]),
		rt.call_function('human_time_diff', [
			rt.add(var_last_sent, var_rate_limit),
		]),
	])
	return (create_wp_error(rt.new_string('email_sent_already'), var_err_message.dup())).to_bool()
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) clear_rate_limit() rt.PhpVal {
	return rt.call_function('delete_option', [
		Class_WP_Recovery_Mode_Email_Service.rate_limit_option(),
	])
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) send_recovery_mode_email(var_rate_limit rt.PhpVal, var_error rt.PhpVal, var_extension rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_method(this.link_service, 'generate_url', []rt.PhpVal{})
	mut var_blogname := rt.call_function('wp_specialchars_decode', [
		rt.call_function('get_option', [rt.new_string('blogname')]),
		rt.get_constant('ENT_QUOTES'),
	])
	mut var_switched_locale := rt.call_function('switch_to_locale', [
		rt.call_function('get_locale', []rt.PhpVal{}),
	])
	if rt.is_true(var_extension) {
		mut var_cause := this.get_cause(var_extension.dup())
		mut var_details := rt.call_function('wp_strip_all_tags', [
			rt.call_function('wp_get_extension_error_description', [
				var_error.dup()]),
		])
		if rt.is_true(var_details) {
			mut var_header := rt.call_function('__', [rt.new_string('Error Details')])
			var_details = rt.new_string('\n\n' + var_header.str() + '\n' +
				(rt.call_function('str_pad', [rt.new_string(''), rt.new_int(var_header.dup().to_string().len), rt.new_string('=')])).str() +
				'\n' + var_details.str())
		}
	} else {
		var_cause = rt.new_string(rt.new_string(''))
		var_details = rt.new_string(rt.new_string(''))
	}
	mut var_support := rt.call_function('apply_filters', [
		rt.new_string('recovery_email_support_info'),
		rt.call_function('__', [
			rt.new_string('Please contact your host for assistance with investigating this issue further.'),
		]),
	])
	mut var_debug := rt.call_function('apply_filters', [
		rt.new_string('recovery_email_debug_info'),
		this.get_debug(var_extension.dup()),
	])
	mut var_message := rt.call_function('__', [
		rt.new_string('Howdy!\n\nWordPress has a built-in feature that detects when a plugin or theme causes a fatal error on your site, and notifies you with this automated email.\n###CAUSE###\nFirst, visit your website (###SITEURL###) and check for any visible issues. Next, visit the page where the error was caught (###PAGEURL###) and check for any visible issues.\n\n###SUPPORT###\n\nIf your site appears broken and you can\'t access your dashboard normally, WordPress now has a special "recovery mode". This lets you safely login to your dashboard and investigate further.\n\n###LINK###\n\nTo keep your site safe, this link will expire in ###EXPIRES###. Don\'t worry about that, though: a new link will be emailed to you if the error occurs again after it expires.\n\nWhen seeking help with this issue, you may be asked for some of the following information:\n###DEBUG###\n\n###DETAILS###'),
	])
	var_message = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '###LINK###' },
			rt.ArrayItem{ key: none, val: '###EXPIRES###' }, rt.ArrayItem{
				key: none
				val: '###CAUSE###'
			}, rt.ArrayItem{ key: none, val: '###DETAILS###' },
			rt.ArrayItem{ key: none, val: '###SITEURL###' }, rt.ArrayItem{
				key: none
				val: '###PAGEURL###'
			}, rt.ArrayItem{ key: none, val: '###SUPPORT###' },
			rt.ArrayItem{ key: none, val: '###DEBUG###' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: var_url },
			rt.ArrayItem{ key: none, val: rt.call_function('human_time_diff', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), var_rate_limit),
			]) }, rt.ArrayItem{
				key: none
				val: if rt.is_true(var_cause) { '\n${var_cause.to_string()}\n' } else { '\n' }
			}, rt.ArrayItem{ key: none, val: var_details }, rt.ArrayItem{ key: none, val: rt.call_function('home_url', [
				rt.new_string('/'),
			]) }, rt.ArrayItem{ key: none, val: rt.call_function('home_url', [
				rt.get_superglobal('_SERVER').array_get('REQUEST_URI'),
			]) }, rt.ArrayItem{ key: none, val: var_support },
			rt.ArrayItem{ key: none, val: rt.call_function('implode', [
				rt.new_string('\r\n'),
				var_debug.dup(),
			]) }]),
		var_message.dup(),
	])
	mut var_email := rt.create_array([
		rt.ArrayItem{ key: 'to', val: this.get_recovery_mode_email_address() },
		rt.ArrayItem{ key: 'subject', val: rt.call_function('__', [
			rt.new_string('[%s] Your Site is Experiencing a Technical Issue'),
		]) },
		rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'headers', val: '' },
		rt.ArrayItem{ key: 'attachments', val: '' },
	])
	var_email = rt.call_function('apply_filters', [rt.new_string('recovery_mode_email'),
		var_email.dup(), var_url.dup()])
	mut var_sent := rt.call_function('wp_mail', [var_email.array_get('to'),
		rt.call_function('wp_specialchars_decode', [
			rt.call_function('sprintf', [var_email.array_get('subject'),
				var_blogname.dup()]),
		]),
		var_email.array_get('message'), var_email.array_get('headers'),
		var_email.array_get('attachments')])
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	return var_sent.dup()
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) get_recovery_mode_email_address() rt.PhpVal {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('RECOVERY_MODE_EMAIL')]))
		&& rt.is_true(rt.call_function('is_email', [rt.get_constant('RECOVERY_MODE_EMAIL')]))))
	{
		return rt.get_constant('RECOVERY_MODE_EMAIL')
	}
	return rt.call_function('get_option', [rt.new_string('admin_email')])
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) get_cause(var_extension rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('plugin'), var_extension.array_get('type'))) {
		mut var_plugin := rt.new_bool(this.get_plugin(var_extension.dup()))
		if rt.is_true(rt.identical(rt.new_bool(false), var_plugin)) {
			mut var_name := var_extension.array_get('slug')
		} else {
			var_name = var_plugin.array_get('Name')
		}
		mut var_cause := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('In this case, WordPress caught an error with one of your plugins, %s.'),
			]),
			var_name.dup(),
		])
	} else {
		mut var_theme := rt.call_function('wp_get_theme', [var_extension.array_get('slug')])
		var_name = if rt.is_true(rt.call_method(var_theme, 'exists', []rt.PhpVal{})) { rt.call_method(var_theme, 'display', [
				rt.new_string('Name'),
			]) } else { var_extension.array_get('slug') }
		var_cause = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('In this case, WordPress caught an error with your theme, %s.'),
			]),
			var_name.dup(),
		])
	}
	return var_cause.dup()
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) get_plugin(var_extension rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugins'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	if var_plugins.array_isset(rt.concat(rt.concat(rt.concat(var_extension.array_get('slug'),
		rt.new_string('/')), var_extension.array_get('slug')), rt.new_string('.php')))
	{
		return (var_plugins.array_get(rt.concat(rt.concat(rt.concat(var_extension.array_get('slug'),
			rt.new_string('/')), var_extension.array_get('slug')), rt.new_string('.php')))).to_bool()
	} else {
		{
			mut iter_1 := var_plugins.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_plugin_data := item_1.val
				mut var_file := item_1.key
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.call_function('str_starts_with', [var_file.dup(), rt.concat(var_extension.array_get('slug'), rt.new_string('/'))]))
					|| rt.is_true(rt.identical(var_file, var_extension.array_get('slug')))))
				{
					return var_plugin_data.to_bool()
				}
			}
		}
	}
	return false
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) get_debug(var_extension rt.PhpVal) rt.PhpVal {
	mut var_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_wp_version := rt.call_function('get_bloginfo', [rt.new_string('version')])
	mut var_debug := rt.create_array([
		rt.ArrayItem{ key: 'wp', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('WordPress version %s')]),
			var_wp_version.dup(),
		]) },
		rt.ArrayItem{ key: 'theme', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Active theme: %1$s (version %2$s)')]),
			rt.call_method(var_theme, 'get', [rt.new_string('Name')]),
			rt.call_method(var_theme, 'get', [rt.new_string('Version')]),
		]) },
	])
	if rt.is_true(var_extension) {
		mut var_plugin := rt.new_bool(this.get_plugin(var_extension.dup()))
		if rt.is_true(rt.new_bool(var_plugin.dup().is_array())) {
			var_debug.array_set('plugin', rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Current plugin: %1$s (version %2$s)'),
				]),
				var_plugin.array_get('Name'),
				var_plugin.array_get('Version'),
			]))
		}
	}
	var_debug.array_set('php', rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('PHP version %s')]),
		rt.get_constant('PHP_VERSION'),
	]))
	return var_debug.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_recovery_mode_email_service(arg_0 rt.PhpVal) &Class_WP_Recovery_Mode_Email_Service {
	mut obj := &Class_WP_Recovery_Mode_Email_Service{
		PhpObjectBase: rt.PhpObjectBase{}
		link_service:  rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Recovery_Mode_Link_Service](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_send_recovery_mode_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.maybe_send_recovery_mode_email(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'clear_rate_limit' {
			return this.clear_rate_limit()
		}
		'send_recovery_mode_email' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.send_recovery_mode_email(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_recovery_mode_email_address' {
			return this.get_recovery_mode_email_address()
		}
		'get_cause' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_cause(dispatch_arg_0)
		}
		'get_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_plugin(dispatch_arg_0))
		}
		'get_debug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_debug(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Recovery_Mode_Email_Service) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'link_service' { return this.link_service }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Recovery_Mode_Email_Service) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'link_service' {
			this.link_service = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_includes_class_wp_recovery_mode_email_service_php() {
}
