import rt

struct Class_WP_PHPMailer {
	rt.PhpObjectBase
}

fn (mut this Class_WP_PHPMailer) construct(exceptions bool) {
	this.Class_PHPMailer_PHPMailer_PHPMailer.construct(rt.new_bool(exceptions))
	Class_WP_PHPMailer.setlanguage()
}

fn Class_WP_PHPMailer.setlanguage(langcode string, lang_path string) bool {
	rt.set_static_prop('WP_PHPMailer', 'language', rt.create_array([
		rt.ArrayItem{ key: 'authenticate', val: rt.call_function('__', [
			rt.new_string('SMTP Error: Could not authenticate.'),
		]) },
		rt.ArrayItem{ key: 'buggy_php', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your version of PHP is affected by a bug that may result in corrupted messages. To fix it, switch to sending using SMTP, disable the %1$s option in your %2$s, or switch to MacOS or Linux, or upgrade your PHP version.'),
			]),
			rt.new_string('mail.add_x_header'),
			rt.new_string('php.ini'),
		]) },
		rt.ArrayItem{ key: 'connect_host', val: rt.call_function('__', [
			rt.new_string('SMTP Error: Could not connect to SMTP host.'),
		]) },
		rt.ArrayItem{ key: 'data_not_accepted', val: rt.call_function('__', [
			rt.new_string('SMTP Error: Data not accepted.'),
		]) },
		rt.ArrayItem{ key: 'empty_message', val: rt.call_function('__', [
			rt.new_string('Message body empty'),
		]) },
		rt.ArrayItem{ key: 'encoding', val: rt.call_function('__', [
			rt.new_string('Unknown encoding: '),
		]) },
		rt.ArrayItem{ key: 'execute', val: rt.call_function('__', [
			rt.new_string('Could not execute: '),
		]) },
		rt.ArrayItem{ key: 'extension_missing', val: rt.call_function('__', [
			rt.new_string('Extension missing: '),
		]) },
		rt.ArrayItem{ key: 'file_access', val: rt.call_function('__', [
			rt.new_string('Could not access file: '),
		]) },
		rt.ArrayItem{ key: 'file_open', val: rt.call_function('__', [
			rt.new_string('File Error: Could not open file: '),
		]) },
		rt.ArrayItem{ key: 'from_failed', val: rt.call_function('__', [
			rt.new_string('The following From address failed: '),
		]) },
		rt.ArrayItem{ key: 'instantiate', val: rt.call_function('__', [
			rt.new_string('Could not instantiate mail function.'),
		]) },
		rt.ArrayItem{ key: 'invalid_address', val: rt.call_function('__', [
			rt.new_string('Invalid address: '),
		]) },
		rt.ArrayItem{ key: 'invalid_header', val: rt.call_function('__', [
			rt.new_string('Invalid header name or value'),
		]) },
		rt.ArrayItem{ key: 'invalid_hostentry', val: rt.call_function('__', [
			rt.new_string('Invalid host entry: '),
		]) },
		rt.ArrayItem{ key: 'invalid_host', val: rt.call_function('__', [
			rt.new_string('Invalid host: '),
		]) },
		rt.ArrayItem{ key: 'mailer_not_supported', val: rt.call_function('__', [
			rt.new_string(' mailer is not supported.'),
		]) },
		rt.ArrayItem{ key: 'provide_address', val: rt.call_function('__', [
			rt.new_string('You must provide at least one recipient email address.'),
		]) },
		rt.ArrayItem{ key: 'recipients_failed', val: rt.call_function('__', [
			rt.new_string('SMTP Error: The following recipients failed: '),
		]) },
		rt.ArrayItem{ key: 'signing', val: rt.call_function('__', [
			rt.new_string('Signing Error: '),
		]) },
		rt.ArrayItem{ key: 'smtp_code', val: rt.call_function('__', [
			rt.new_string('SMTP code: '),
		]) },
		rt.ArrayItem{ key: 'smtp_code_ex', val: rt.call_function('__', [
			rt.new_string('Additional SMTP info: '),
		]) },
		rt.ArrayItem{ key: 'smtp_connect_failed', val: rt.call_function('__', [
			rt.new_string('SMTP connect() failed.'),
		]) },
		rt.ArrayItem{ key: 'smtp_detail', val: rt.call_function('__', [
			rt.new_string('Detail: '),
		]) },
		rt.ArrayItem{ key: 'smtp_error', val: rt.call_function('__', [
			rt.new_string('SMTP server error: '),
		]) },
		rt.ArrayItem{ key: 'variable_set', val: rt.call_function('__', [
			rt.new_string('Cannot set or reset variable: '),
		]) },
		rt.ArrayItem{ key: 'no_smtputf8', val: rt.call_function('__', [
			rt.new_string('Server does not support SMTPUTF8 needed to send to Unicode addresses'),
		]) },
		rt.ArrayItem{ key: 'imap_recommended', val: rt.call_function('__', [
			rt.new_string('Using simplified address parser is not recommended. Install the PHP IMAP extension for full RFC822 parsing.'),
		]) },
		rt.ArrayItem{ key: 'deprecated_argument', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Argument %s is deprecated'),
			]),
			rt.new_string('$useimap'),
		]) },
	]))
	return true
}

struct Class_PHPMailer_PHPMailer_PHPMailer {
	rt.PhpObjectBase
}

fn create_wp_phpmailer(exceptions bool) &Class_WP_PHPMailer {
	mut obj := &Class_WP_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(exceptions)
	return obj
}

fn create_phpmailer_phpmailer_phpmailer(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_PHPMailer {
	mut obj := &Class_PHPMailer_PHPMailer_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'setLanguage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(Class_WP_PHPMailer.setlanguage(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
