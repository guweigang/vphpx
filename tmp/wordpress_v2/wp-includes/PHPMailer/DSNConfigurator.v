import rt

struct Class_PHPMailer_PHPMailer_DSNConfigurator {
	rt.PhpObjectBase
}

fn Class_PHPMailer_PHPMailer_DSNConfigurator.mailer(var_dsn rt.PhpVal, var_exceptions rt.PhpVal) rt.PhpVal {
	mut var_configurator := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_configurator)) {
		var_configurator = create_phpmailer_phpmailer_dsnconfigurator()
	}
	return var_configurator.configure(mut rt.cast_object_ptr[Class_PHPMailer_PHPMailer_PHPMailer](create_phpmailer_phpmailer_phpmailer(var_exceptions.clone())),
		var_dsn.clone())
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) configure(mut var_mailer Class_PHPMailer_PHPMailer_PHPMailer, var_dsn rt.PhpVal) rt.PhpVal {
	mut var_mailer_mutated := var_mailer
	mut var_config := this.parsedsn(var_dsn.clone())
	this.applyconfig(mut var_mailer_mutated, var_config.clone())
	return rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, var_mailer_mutated)
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) parsedsn(var_dsn rt.PhpVal) rt.PhpVal {
	mut var_config := rt.new_bool(this.parseurl(var_dsn.clone()))
	if rt.is_true(rt.identical(rt.new_bool(false), var_config))
		|| !(var_config.array_isset(rt.new_string('scheme')))
		|| !(var_config.array_isset(rt.new_string('host'))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
			create_phpmailer_phpmailer_exception(rt.new_string('Malformed DSN'))))
	}
	if var_config.array_isset(rt.new_string('query')) {
		rt.call_function('parse_str', [var_config.array_get(rt.new_string('query')),
			var_config.array_get(rt.new_string('query'))])
	}
	return var_config.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) applyconfig(mut var_mailer Class_PHPMailer_PHPMailer_PHPMailer, var_config rt.PhpVal) {
	mut var_mailer_mutated := var_mailer
	mut var_config_mutated := var_config
	mut switch_val_1 := var_config_mutated.array_get(rt.new_string('scheme'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('mail'))) {
		rt.call_method(var_mailer_mutated, 'isMail', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('sendmail'))) {
		rt.call_method(var_mailer_mutated, 'isSendmail', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('qmail'))) {
		rt.call_method(var_mailer_mutated, 'isQmail', []rt.PhpVal{})
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('smtp')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('smtps'))) {
		rt.call_method(var_mailer_mutated, 'isSMTP', []rt.PhpVal{})
		this.configuresmtp(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{},
			var_mailer_mutated), var_config_mutated.clone())
	} else {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(rt.call_function('sprintf', [
			rt.new_string('Invalid scheme: "%s". Allowed values: "mail", "sendmail", "qmail", "smtp", "smtps".'),
			var_config_mutated.array_get(rt.new_string('scheme')),
		]))))
	}
	if var_config_mutated.array_isset(rt.new_string('query')) {
		this.configureoptions(mut var_mailer_mutated,
			var_config_mutated.array_get(rt.new_string('query')))
	}
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) configuresmtp(var_mailer rt.PhpVal, var_config rt.PhpVal) {
	mut var_mailer_mutated := var_mailer
	mut var_config_mutated := var_config
	mut var_isSMTPS := rt.identical(rt.new_string('smtps'),
		var_config_mutated.array_get(rt.new_string('scheme')))
	if rt.is_true(var_isSMTPS) {
		rt.set_property(var_mailer_mutated, 'SMTPSecure',
			Class_PHPMailer_PHPMailer_PHPMailer.encryption_starttls())
	}
	rt.set_property(var_mailer_mutated, 'Host', var_config_mutated.array_get(rt.new_string('host')))
	if var_config_mutated.array_isset(rt.new_string('port')) {
		rt.set_property(var_mailer_mutated, 'Port',
			var_config_mutated.array_get(rt.new_string('port')))
	} else if rt.is_true(var_isSMTPS) {
		rt.set_property(var_mailer_mutated, 'Port',
			Class_PHPMailer_PHPMailer_SMTP.default_secure_port())
	}
	rt.set_property(var_mailer_mutated, 'SMTPAuth', rt.new_bool(
		var_config_mutated.array_isset(rt.new_string('user'))
		|| var_config_mutated.array_isset(rt.new_string('pass'))))
	if var_config_mutated.array_isset(rt.new_string('user')) {
		rt.set_property(var_mailer_mutated, 'Username',
			var_config_mutated.array_get(rt.new_string('user')))
	}
	if var_config_mutated.array_isset(rt.new_string('pass')) {
		rt.set_property(var_mailer_mutated, 'Password',
			var_config_mutated.array_get(rt.new_string('pass')))
	}
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) configureoptions(mut var_mailer Class_PHPMailer_PHPMailer_PHPMailer, var_options rt.PhpVal) {
	mut var_mailer_mutated := var_mailer
	mut var_allowedOptions := rt.call_function('get_object_vars', [var_mailer_mutated])
	var_allowedOptions.array_unset(rt.new_string('Mailer'))
	var_allowedOptions.array_unset(rt.new_string('SMTPAuth'))
	var_allowedOptions.array_unset(rt.new_string('Username'))
	var_allowedOptions.array_unset(rt.new_string('Password'))
	var_allowedOptions.array_unset(rt.new_string('Hostname'))
	var_allowedOptions.array_unset(rt.new_string('Port'))
	var_allowedOptions.array_unset(rt.new_string('ErrorInfo'))
	var_allowedOptions = rt.func_array_keys(var_allowedOptions.clone())
	mut iter_1 := var_options.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_key.clone(), var_allowedOptions.clone()])))))
		{
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(rt.call_function('sprintf', [
				rt.new_string('Unknown option: "%s". Allowed values: "%s"'),
				var_key.clone(),
				rt.call_function('implode', [rt.new_string('", "'),
					var_allowedOptions.clone()]),
			]))))
		}
		mut switch_val_2 := var_key
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('AllowEmpty')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('SMTPAutoTLS')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('SMTPKeepAlive')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('SingleTo')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('UseSendmailOptions')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('do_verp')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('DKIM_copyHeaderFields'))) {
			rt.set_property(var_mailer_mutated,
				'{"nodeType":"Expr_Variable","line":206,"name":"key"}', var_value.to_bool())
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('Priority')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('SMTPDebug')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('WordWrap'))) {
			rt.set_property(var_mailer_mutated,
				'{"nodeType":"Expr_Variable","line":211,"name":"key"}',
				rt.new_int(var_value.to_i64()))
		} else {
			rt.set_property(var_mailer_mutated,
				'{"nodeType":"Expr_Variable","line":214,"name":"key"}', var_value.clone())
		}
	}
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) parseurl(var_url rt.PhpVal) bool {
	if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50600)))
		|| rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_url.clone(), rt.new_string('?')]))) {
		return (rt.call_function('parse_url', [var_url.clone()])).to_bool()
	}
	mut var_chunks := rt.call_function('explode', [rt.new_string('?'),
		var_url.clone()])
	if rt.is_true(rt.new_bool(var_chunks.clone().is_array())) {
		mut var_result := rt.call_function('parse_url', [var_chunks.array_get(rt.new_int(0))])
		if rt.is_true(rt.new_bool(var_result.clone().is_array())) {
			var_result.array_set('query', var_chunks.array_get(rt.new_int(1)))
		}
		return var_result.to_bool()
	}
	return false
}

struct Class_PHPMailer_PHPMailer_PHPMailer {
	rt.PhpObjectBase
}

struct Class_PHPMailer_PHPMailer_Exception {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_dsnconfigurator(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_DSNConfigurator {
	mut obj := &Class_PHPMailer_PHPMailer_DSNConfigurator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_phpmailer_phpmailer_phpmailer(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_PHPMailer {
	mut obj := &Class_PHPMailer_PHPMailer_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_phpmailer_phpmailer_exception(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_Exception {
	mut obj := &Class_PHPMailer_PHPMailer_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'mailer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_DSNConfigurator.mailer(dispatch_arg_0, dispatch_arg_1)
		}
		'configure' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_PHPMailer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.configure(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseDSN' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsedsn(dispatch_arg_0)
		}
		'applyConfig' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_PHPMailer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.applyconfig(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'configureSMTP' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.configuresmtp(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'configureOptions' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_PHPMailer](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.configureoptions(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parseUrl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.parseurl(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_PHPMailer_PHPMailer_DSNConfigurator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_DSNConfigurator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_PHPMailer_PHPMailer_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
