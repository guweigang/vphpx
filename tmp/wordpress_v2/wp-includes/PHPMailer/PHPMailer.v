import rt

pub fn Class_PHPMailer_PHPMailer_PHPMailer.charset_ascii() string {
	return 'us-ascii'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.charset_iso88591() string {
	return 'iso-8859-1'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.charset_utf8() string {
	return 'utf-8'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_plaintext() string {
	return 'text/plain'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_text_calendar() string {
	return 'text/calendar'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_text_html() string {
	return 'text/html'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_multipart_alternative() string {
	return 'multipart/alternative'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_multipart_mixed() string {
	return 'multipart/mixed'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.content_type_multipart_related() string {
	return 'multipart/related'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encoding_7bit() string {
	return '7bit'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encoding_8bit() string {
	return '8bit'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encoding_base64() string {
	return 'base64'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encoding_binary() string {
	return 'binary'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encoding_quoted_printable() string {
	return 'quoted-printable'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encryption_starttls() string {
	return 'tls'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.encryption_smtps() string {
	return 'ssl'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_request() string {
	return 'REQUEST'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_publish() string {
	return 'PUBLISH'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_reply() string {
	return 'REPLY'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_add() string {
	return 'ADD'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_cancel() string {
	return 'CANCEL'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_refresh() string {
	return 'REFRESH'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_counter() string {
	return 'COUNTER'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.ical_method_declinecounter() string {
	return 'DECLINECOUNTER'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.version() string {
	return '7.0.2'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.stop_message() i64 {
	return 0
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.stop_continue() i64 {
	return 1
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.stop_critical() i64 {
	return 2
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.crlf() string {
	return '\r\n'
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.fws() string {
	return ' '
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.mail_max_line_length() i64 {
	return 63
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.max_line_length() i64 {
	return 998
}

pub fn Class_PHPMailer_PHPMailer_PHPMailer.std_line_length() i64 {
	return 76
}

struct Class_PHPMailer_PHPMailer_PHPMailer {
	rt.PhpObjectBase
pub mut:
	Priority              rt.PhpVal = rt.new_null()
	CharSet               rt.PhpVal = rt.new_null()
	ContentType           rt.PhpVal = rt.new_null()
	Encoding              rt.PhpVal = rt.new_null()
	ErrorInfo             rt.PhpVal = rt.new_string('')
	From                  rt.PhpVal = rt.new_string('')
	FromName              rt.PhpVal = rt.new_string('')
	Sender                rt.PhpVal = rt.new_string('')
	Subject               string
	Body                  rt.PhpVal = rt.new_string('')
	AltBody               rt.PhpVal = rt.new_string('')
	Ical                  rt.PhpVal = rt.new_string('')
	MIMEBody              rt.PhpVal = rt.new_string('')
	MIMEHeader            rt.PhpVal = rt.new_string('')
	mailHeader            string
	WordWrap              rt.PhpVal = rt.new_int(0)
	Mailer                string
	Sendmail              rt.PhpVal = rt.new_string('/usr/sbin/sendmail')
	UseSendmailOptions    rt.PhpVal = rt.new_bool(true)
	ConfirmReadingTo      rt.PhpVal = rt.new_string('')
	Hostname              rt.PhpVal = rt.new_string('')
	MessageID             rt.PhpVal = rt.new_string('')
	MessageDate           rt.PhpVal = rt.new_string('')
	Host                  string
	Port                  rt.PhpVal = rt.new_int(25)
	Helo                  rt.PhpVal = rt.new_string('')
	SMTPSecure            rt.PhpVal = rt.new_string('')
	SMTPAutoTLS           rt.PhpVal = rt.new_bool(true)
	SMTPAuth              rt.PhpVal = rt.new_bool(false)
	SMTPOptions           rt.PhpVal = rt.new_array()
	Username              rt.PhpVal = rt.new_string('')
	Password              rt.PhpVal = rt.new_string('')
	AuthType              rt.PhpVal = rt.new_string('')
	SMTPXClient           rt.PhpVal = rt.new_array()
	oauth                 rt.PhpVal = rt.new_null()
	Timeout               rt.PhpVal = rt.new_int(300)
	dsn                   rt.PhpVal = rt.new_string('')
	SMTPDebug             rt.PhpVal = rt.new_int(0)
	Debugoutput           string
	SMTPKeepAlive         rt.PhpVal = rt.new_bool(false)
	SingleTo              rt.PhpVal = rt.new_bool(false)
	SingleToArray         rt.PhpVal = rt.new_array()
	do_verp               rt.PhpVal = rt.new_bool(false)
	AllowEmpty            rt.PhpVal = rt.new_bool(false)
	DKIM_selector         rt.PhpVal = rt.new_string('')
	DKIM_identity         rt.PhpVal = rt.new_string('')
	DKIM_passphrase       rt.PhpVal = rt.new_string('')
	DKIM_domain           rt.PhpVal = rt.new_string('')
	DKIM_copyHeaderFields rt.PhpVal = rt.new_bool(true)
	DKIM_extraHeaders     rt.PhpVal = rt.new_array()
	DKIM_private          rt.PhpVal = rt.new_string('')
	DKIM_private_string   rt.PhpVal = rt.new_string('')
	action_function       rt.PhpVal = rt.new_string('')
	XMailer               rt.PhpVal = rt.new_string('')
	smtp                  rt.PhpVal = rt.new_null()
	to                    rt.PhpVal = rt.new_array()
	cc                    rt.PhpVal = rt.new_array()
	bcc                   rt.PhpVal = rt.new_array()
	ReplyTo               rt.PhpVal = rt.new_array()
	all_recipients        rt.PhpVal = rt.new_array()
	RecipientsQueue       rt.PhpVal = rt.new_array()
	ReplyToQueue          rt.PhpVal = rt.new_array()
	UseSMTPUTF8           bool
	attachment            rt.PhpVal = rt.new_array()
	CustomHeader          rt.PhpVal = rt.new_array()
	lastMessageID         rt.PhpVal = rt.new_string('')
	message_type          rt.PhpVal = rt.new_string('')
	boundary              rt.PhpVal = rt.new_array()
	error_count           i64
	sign_cert_file        rt.PhpVal = rt.new_string('')
	sign_key_file         rt.PhpVal = rt.new_string('')
	sign_extracerts_file  rt.PhpVal = rt.new_string('')
	sign_key_pass         rt.PhpVal = rt.new_string('')
	exceptions            rt.PhpVal = rt.new_bool(false)
	uniqueid              rt.PhpVal = rt.new_string('')
}

fn init_static_phpmailer_phpmailer_phpmailer() {
	rt.init_static_prop('PHPMailer_PHPMailer_PHPMailer', 'IcalMethods', rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_request()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_publish()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_reply()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_add()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_cancel()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_refresh()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_counter()
		},
		rt.ArrayItem{
			key: none
			val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.ical_method_declinecounter()
		},
	]))
	rt.init_static_prop('PHPMailer_PHPMailer_PHPMailer', 'validator', rt.new_string('php'))
	rt.init_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language', rt.new_array())
	rt.init_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE',
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf())
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) construct(var_exceptions rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_exceptions)))) {
		this.exceptions = var_exceptions.to_bool()
	}
	this.Debugoutput = if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		rt.get_constant('PHP_SAPI'),
		rt.new_string('cli'),
	]), rt.new_bool(false)))))
	{ 'echo' } else { 'html' }
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) magic_destruct() {
	this.smtpclose()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) mailpassthru(var_to rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal, var_header rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_to_mutated := var_to
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
	mut var_header_mutated := var_header
	mut var_params_mutated := var_params
	if rt.is_true(rt.new_int((rt.call_function('ini_get', [
		rt.new_string('mbstring.func_overload'),
	])).to_i64()) & 1)
	{
		var_subject_mutated = rt.new_string(this.secureheader(var_subject_mutated.clone()))
	} else {
		var_subject_mutated =
			rt.new_string(this.encodeheader(rt.new_string(this.secureheader(var_subject_mutated.clone())), ''))
	}
	this.edebug(rt.new_string('Sending with mail()'))
	this.edebug(rt.new_string('Sendmail path: ' +
		(rt.call_function('ini_get', [rt.new_string('sendmail_path')])).str()))
	this.edebug(rt.new_string((rt.concat(rt.new_string('Envelope sender: '), this.Sender)).str()))
	this.edebug(rt.new_string('To: ${var_to.to_string()}'))
	this.edebug(rt.new_string('Subject: ${var_subject.to_string()}'))
	this.edebug(rt.new_string('Headers: ${var_header.to_string()}'))
	if rt.is_true(rt.new_bool(!(rt.is_true(this.UseSendmailOptions))))
		|| rt.is_true(rt.identical(rt.new_null(), var_params_mutated)) {
		mut var_result := rt.call_function('mail', [var_to_mutated.clone(),
			var_subject_mutated.clone(), var_body_mutated.clone(),
			var_header_mutated.clone()])
	} else {
		this.edebug(rt.new_string('Additional params: ${var_params.to_string()}'))
		var_result = rt.call_function('mail', [var_to_mutated.clone(),
			var_subject_mutated.clone(), var_body_mutated.clone(),
			var_header_mutated.clone(), var_params_mutated.clone()])
	}
	this.edebug(rt.new_string('Result: ' + if rt.is_true(var_result) { 'true' } else { 'false' }))
	return var_result.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) edebug(var_str rt.PhpVal) {
	mut var_str_mutated := var_str
	if rt.is_true(rt.less_equal(this.SMTPDebug, rt.new_int(0))) {
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(this.Debugoutput,
		'PHPMailer_PHPMailer_Psr_Log_LoggerInterface')))
	{
		rt.call_method(this.Debugoutput, 'debug', [
			rt.new_string(var_str_mutated.clone().to_string().trim_right(' \t\n\r')),
		])
		return
	}
	if rt.call_function('is_callable', [rt.new_string(this.Debugoutput)])
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(this.Debugoutput), rt.create_array([rt.ArrayItem{
		key: none
		val: 'error_log'
	}, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'echo' }])]))))) {
		rt.call_function('call_user_func', [rt.new_string(this.Debugoutput),
			var_str_mutated.clone(), this.SMTPDebug])
		return
	}
	mut switch_val_1 := this.Debugoutput
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_log'))) {
		rt.call_function('error_log', [var_str_mutated.clone()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		rt.echo_val(rt.call_function('htmlentities', [
			rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'),
				rt.new_string(''), var_str_mutated.clone()]),
			rt.get_constant('ENT_QUOTES'),
			rt.new_string('UTF-8'),
		]))
		print('<br>\n')
	} else {
		var_str_mutated = rt.call_function('preg_replace', [
			rt.new_string('/\\r\\n|\\r/m'),
			rt.new_string('\n'),
			var_str_mutated.clone(),
		])
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print('\t')
		print(rt.call_function('str_replace', [rt.new_string('\n'),
			rt.new_string('\n                   \t                  '),
			rt.new_string(var_str_mutated.clone().to_string().trim_space())]).to_string().trim_space())
		print('\n')
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) ishtml(isHtml bool) {
	if var_isHtml {
		this.ContentType = Class_PHPMailer_PHPMailer_static.content_type_text_html()
	} else {
		this.ContentType = Class_PHPMailer_PHPMailer_static.content_type_plaintext()
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) issmtp() {
	this.Mailer = 'smtp'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) ismail() {
	this.Mailer = 'mail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) parsesendmailpath(var_sendmailPath rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_sendmailPath_mutated := var_sendmailPath
	var_sendmailPath_mutated = rt.new_string(var_sendmailPath_mutated.str().trim_space())
	if rt.is_true(rt.identical(var_sendmailPath_mutated, rt.new_string(''))) {
		return var_sendmailPath_mutated.clone()
	}
	mut var_parts := rt.call_function('preg_split', [rt.new_string('/\\s+/'),
		var_sendmailPath_mutated.clone()])
	if !rt.is_true(var_parts) {
		return var_sendmailPath_mutated.clone()
	}
	mut var_command := rt.call_function('array_shift', [var_parts.clone()])
	mut var_remainder := rt.new_array()
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(var_parts.clone().array_count())))) { break
		 }
		mut var_part := var_parts.array_get(var_i)
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^-(i|oi|t)$/'),
			var_part.clone(), var_matches.clone()]))
		{
			continue
		}
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^-f(.*)$/'),
			var_part.clone(), var_matches.clone()]))
		{
			mut var_address := var_matches.array_get(rt.new_int(1))
			if rt.is_true(rt.identical(var_address, rt.new_string('')))
				&& var_parts.array_isset(rt.add(var_i, rt.new_int(1)))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_parts.array_get(rt.add(var_i, rt.new_int(1))), rt.new_string('-')]), rt.new_int(0))))) {
				var_address = var_parts.array_get(rt.pre_inc(var_i))
			}
			this.Sender = var_address.clone()
			continue
		}
		var_remainder.array_push(var_part.clone())
		rt.pre_inc(var_i)
	}
	if !(!rt.is_true(var_remainder)) {
		var_command = rt.concat(var_command, rt.new_string(' ' +
			(rt.call_function('implode', [rt.new_string(' '), var_remainder.clone()])).str()))
	}
	return var_command.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) issendmail() {
	mut var_ini_sendmail_path := rt.call_function('ini_get', [
		rt.new_string('sendmail_path'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_ini_sendmail_path.clone(),
		rt.new_string('sendmail'),
	])))
	{
		var_ini_sendmail_path = rt.new_string('/usr/sbin/sendmail')
	}
	this.Sendmail = this.parsesendmailpath(var_ini_sendmail_path.clone())
	this.Mailer = 'sendmail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) isqmail() {
	mut var_ini_sendmail_path := rt.call_function('ini_get', [
		rt.new_string('sendmail_path'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [
		var_ini_sendmail_path.clone(),
		rt.new_string('qmail'),
	])))
	{
		var_ini_sendmail_path = rt.new_string('/var/qmail/bin/qmail-inject')
	}
	this.Sendmail = this.parsesendmailpath(var_ini_sendmail_path.clone())
	this.Mailer = 'qmail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addaddress(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('to'), var_address_mutated.clone(),
		rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addcc(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('cc'), var_address_mutated.clone(),
		rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addbcc(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('bcc'),
		var_address_mutated.clone(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addreplyto(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('Reply-To'),
		var_address_mutated.clone(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addorenqueueanaddress(var_kind rt.PhpVal, var_address rt.PhpVal, var_name rt.PhpVal) bool {
	mut var_address_mutated := var_address
	mut var_name_mutated := var_name
	mut var_pos := rt.new_bool(false)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_address_mutated, rt.new_null())))) {
		var_address_mutated = rt.new_string(var_address_mutated.clone().to_string().trim_space())
		var_pos = rt.call_function('strrpos', [var_address_mutated.clone(),
			rt.new_string('@')])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_pos)) {
		mut var_error_message := rt.call_function('sprintf', [
			rt.new_string('%s (%s): %s'),
			Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')),
			var_kind.clone(),
			var_address_mutated.clone(),
		])
		this.seterror(var_error_message.clone())
		this.edebug(var_error_message.clone())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
				create_phpmailer_phpmailer_exception(var_error_message.clone())))
		}
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name_mutated, rt.new_null()))))
		&& var_name_mutated.clone().is_string() {
		var_name_mutated = rt.new_string(rt.call_function('preg_replace', [
			rt.new_string('/[\\r\\n]+/'),
			rt.new_string(''),
			var_name_mutated.clone(),
		]).to_string().trim_space())
	} else {
		var_name_mutated = rt.new_string('')
	}
	mut var_params := rt.create_array([rt.ArrayItem{ key: none, val: var_kind },
		rt.ArrayItem{ key: none, val: var_address_mutated }, rt.ArrayItem{
			key: none
			val: var_name_mutated
		}])
	if this.has8bitchars(rt.call_function('substr', [var_address_mutated.clone(),
		rt.pre_inc(var_pos)]))
	{
		if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.idnsupported()) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('Reply-To'), var_kind)))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.RecipientsQueue.array_isset(var_address_mutated.clone())))))) {
					this.RecipientsQueue.array_set(var_address_mutated, var_params.clone())
					return true
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.ReplyToQueue.array_isset(var_address_mutated.clone())))))) {
				this.ReplyToQueue.array_set(var_address_mutated, var_params.clone())
				return true
			}
		}
		return false
	}
	return (rt.call_function('call_user_func_array', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_PHPMailer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'addAnAddress' },
		]),
		var_params.clone(),
	])).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setboundaries() {
	this.uniqueid = this.generateid()
	this.boundary.array_set(1, 'b1=_' + (this.uniqueid).str())
	this.boundary.array_set(2, 'b2=_' + (this.uniqueid).str())
	this.boundary.array_set(3, 'b3=_' + (this.uniqueid).str())
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addanaddress(var_kind rt.PhpVal, var_address rt.PhpVal, name string) bool {
	mut var_address_mutated := var_address
	mut name_mutated := name
	if rt.is_true(rt.identical(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'validator'), rt.new_string('php')))
		&& rt.is_true((rt.call_function('preg_match', [rt.new_string('/[\\x80-\\xFF]/'), var_address_mutated.clone()])).to_bool()) {
		this.CharSet = Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.charset_utf8()
		rt.set_static_prop('PHPMailer_PHPMailer_PHPMailer', 'validator', rt.new_string('eai'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_kind.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'to' },
			rt.ArrayItem{ key: none, val: 'cc' }, rt.ArrayItem{ key: none, val: 'bcc' },
			rt.ArrayItem{ key: none, val: 'Reply-To' }])])))))
	{
		mut var_error_message := rt.call_function('sprintf', [
			rt.new_string('%s: %s'),
			Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('Invalid recipient kind')),
			var_kind.clone()])
		this.seterror(var_error_message.clone())
		this.edebug(var_error_message.clone())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
				create_phpmailer_phpmailer_exception(var_error_message.clone())))
		}
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address_mutated.clone()))))) {
		var_error_message = rt.call_function('sprintf', [rt.new_string('%s (%s): %s'),
			Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')),
			var_kind.clone(), var_address_mutated.clone()])
		this.seterror(var_error_message.clone())
		this.edebug(var_error_message.clone())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
				create_phpmailer_phpmailer_exception(var_error_message.clone())))
		}
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('Reply-To'), var_kind)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.all_recipients.array_isset(rt.new_string(var_address_mutated.clone().to_string().to_lower()))))))) {
			rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this),
				'{"nodeType":"Expr_Variable","line":1265,"name":"kind"}').array_push(rt.create_array([
				rt.ArrayItem{ key: none, val: var_address_mutated },
				rt.ArrayItem{ key: none, val: name_mutated },
			]))
			this.all_recipients.array_set(var_address_mutated.clone().to_string().to_lower(), true)
			return true
		}
	} else {
		mut iter_1 := this.ReplyTo.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_replyTo := item_1.val
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [
				var_replyTo.array_get(rt.new_int(0)),
				var_address_mutated.clone(),
			])))
			{
				return false
			}
		}
		this.ReplyTo.array_push(rt.create_array([
			rt.ArrayItem{ key: none, val: var_address_mutated },
			rt.ArrayItem{ key: none, val: name_mutated },
		]))
		return true
	}
	return false
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(var_addrstr rt.PhpVal, var_useimap rt.PhpVal, var_charset rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_useimap, rt.new_null())))) {
		rt.call_function('trigger_error', [
			rt.new_string(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('deprecated_argument'))).str() + '$useimap'),
			rt.get_constant('E_USER_DEPRECATED'),
		])
	}
	mut var_addresses := rt.new_array()
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('imap_rfc822_parse_adrlist'),
	]))
	{
		mut var_list := rt.call_function('imap_rfc822_parse_adrlist', [
			var_addrstr.clone(), rt.new_string('')])
		rt.call_function('imap_errors', []rt.PhpVal{})
		mut iter_2 := var_list.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_address := item_2.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('.SYNTAX-ERROR.'), rt.get_property(var_address, 'host')))))
				&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(rt.new_string((rt.get_property(var_address, 'mailbox')).str() + '@' + (rt.get_property(var_address, 'host')).str()))) {
				if rt.is_true(rt.call_function('property_exists', [var_address.clone(), rt.new_string('personal')]))
					&& rt.get_property(var_address, 'personal').is_string()
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_address, 'personal'), rt.new_string(''))))) {
					rt.set_property(var_address, 'personal', Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(rt.get_property(var_address,
						'personal'), var_charset_mutated.clone()))
				}
				var_addresses.array_push(rt.create_array([
					rt.ArrayItem{
						key: 'name'
						val: if rt.is_true(rt.call_function('property_exists', [
							var_address.clone(),
							rt.new_string('personal'),
						]))
						{ rt.get_property(var_address, 'personal') } else { rt.new_string('') }
					},
					rt.ArrayItem{ key: 'address', val:
						(rt.get_property(var_address, 'mailbox')).str() + '@' +
						(rt.get_property(var_address, 'host')).str() },
				]))
			}
		}
	} else {
		var_addresses = Class_PHPMailer_PHPMailer_PHPMailer.parsesimpleraddresses(var_addrstr.clone(),
			var_charset_mutated.clone())
	}
	return var_addresses.clone()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parsesimpleraddresses(var_addrstr rt.PhpVal, var_charset rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
	rt.call_function('trigger_error', [
		Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('imap_recommended')),
		rt.get_constant('E_USER_NOTICE'),
	])
	mut var_addresses := rt.new_array()
	mut var_list := rt.call_function('explode', [rt.new_string(','),
		var_addrstr.clone()])
	mut iter_3 := var_list.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_address := item_3.val
		var_address = rt.new_string(var_address.clone().to_string().trim_space())
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			var_address.clone(), rt.new_string('<')]), rt.new_bool(false)))
		{
			if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address.clone())) {
				var_addresses.array_push(rt.create_array([
					rt.ArrayItem{ key: 'name', val: '' },
					rt.ArrayItem{ key: 'address', val: var_address },
				]))
			}
		} else {
			mut var_parsed :=
				Class_PHPMailer_PHPMailer_PHPMailer.parseemailstring(var_address.clone())
			mut var_email := var_parsed.array_get(rt.new_string('email'))
			if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_email.clone())) {
				mut var_name := Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(var_parsed.array_get(rt.new_string('name')),
					var_charset_mutated.clone())
				var_addresses.array_push(rt.create_array([
					rt.ArrayItem{ key: 'name', val: var_name.clone().to_string().trim_space() },
					rt.ArrayItem{ key: 'address', val: var_email },
				]))
			}
		}
	}
	return var_addresses.clone()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parseemailstring(var_input rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_input_mutated := var_input
	var_input_mutated = rt.new_string(var_input_mutated.str().trim_space())
	if rt.is_true(rt.identical(var_input_mutated, rt.new_string(''))) {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
			rt.ArrayItem{ key: 'email', val: '' }])
	}
	mut var_pattern :=
		rt.new_string('/^\\s*(?:(?:"([^"]*)"|\'([^\']*)\'|([^<]*?))\\s*)?<\\s*([^>]+)\\s*>\\s*$/')
	if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(),
		var_input_mutated.clone(), var_matches.clone()]))
	{
		mut var_name := rt.new_string('')
		if var_matches.array_isset(rt.new_int(1))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_matches.array_get(rt.new_int(1)), rt.new_string(''))))) {
			var_name = var_matches.array_get(rt.new_int(1))
		} else if var_matches.array_isset(rt.new_int(2))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_matches.array_get(rt.new_int(2)), rt.new_string(''))))) {
			var_name = var_matches.array_get(rt.new_int(2))
		} else if var_matches.array_isset(rt.new_int(3)) {
			var_name = rt.new_string(var_matches.array_get(rt.new_int(3)).to_string().trim_space())
		}
		return rt.create_array([rt.ArrayItem{ key: 'name', val: var_name },
			rt.ArrayItem{
				key: 'email'
				val: var_matches.array_get(rt.new_int(4)).to_string().trim_space()
			}])
	}
	return rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
		rt.ArrayItem{ key: 'email', val: var_input_mutated }])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setfrom(var_address rt.PhpVal, name string, auto bool) bool {
	mut var_address_mutated := var_address
	mut name_mutated := name
	if rt.is_true(rt.new_bool(rt.new_string(name_mutated).clone().is_null())) {
		name_mutated = ''
	}
	var_address_mutated = rt.new_string(var_address_mutated.str().trim_space())
	name_mutated = rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'),
		rt.new_string(''), rt.new_string(name_mutated).clone()]).to_string().trim_space()
	mut var_pos := rt.call_function('strrpos', [var_address_mutated.clone(),
		rt.new_string('@')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_pos))|| (!(this.has8bitchars(rt.call_function('substr', [var_address_mutated.clone(), rt.pre_inc(var_pos)])))
		|| rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.idnsupported()))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address_mutated.clone())))))) {
		mut var_error_message := rt.call_function('sprintf', [
			rt.new_string('%s (From): %s'),
			Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')),
			var_address_mutated.clone(),
		])
		this.seterror(var_error_message.clone())
		this.edebug(var_error_message.clone())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
				create_phpmailer_phpmailer_exception(var_error_message.clone())))
		}
		return false
	}
	this.From = var_address_mutated.clone()
	this.FromName = rt.new_string(name_mutated).clone()
	if var_auto && !rt.is_true(this.Sender) {
		this.Sender = var_address_mutated.clone()
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getlastmessageid() rt.PhpVal {
	return this.lastMessageID
}

fn Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address rt.PhpVal, var_patternselect rt.PhpVal) bool {
	mut var_address_mutated := var_address
	mut var_patternselect_mutated := var_patternselect
	if rt.is_true(rt.identical(rt.new_null(), var_patternselect_mutated)) {
		var_patternselect_mutated = rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'validator')
	}
	if rt.call_function('is_callable', [var_patternselect_mutated.clone()])
		&& !(var_patternselect_mutated.clone().is_string()) {
		return (rt.call_function('call_user_func', [var_patternselect_mutated.clone(),
			var_address_mutated.clone()])).to_bool()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_address_mutated.clone(), rt.new_string('\n')]), rt.new_bool(false)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_address_mutated.clone(), rt.new_string('\r')]), rt.new_bool(false))))) {
		return false
	}
	mut switch_val_2 := var_patternselect_mutated
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('pcre')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('pcre8'))) {
		return (rt.call_function('preg_match', [
			rt.new_string(
				'/^(?!(?>(?1)"?(?>\\\\[ -~]|[^"])"?(?1)){255,})(?!(?>(?1)"?(?>\\\\[ -~]|[^"])"?(?1)){65,}@)' +
				'((?>(?>(?>((?>(?>(?>\\x0D\\x0A)?[\\t ])+|(?>[\\t ]*\\x0D\\x0A)?[\\t ]+)?)(\\((?>(?2)' +
				"(?>[\\x01-\\x08\\x0B\\x0C\\x0E-'*-\\[\\]-\\x7F]|\\\\[\\x00-\\x7F]|(?3)))*(?2)\\)))+(?2))|(?2))?)" +
				'([!#-\'*+\\/-9=?^-~-]+|"(?>(?2)(?>[\\x01-\\x08\\x0B\\x0C\\x0E-!#-\\[\\]-\\x7F]|\\\\[\\x00-\\x7F]))*' +
				'(?2)")(?>(?1)\\.(?1)(?4))*(?1)@(?!(?1)[a-z0-9-]{64,})(?1)(?>([a-z0-9](?>[a-z0-9-]*[a-z0-9])?)' +
				'(?>(?1)\\.(?!(?1)[a-z0-9-]{64,})(?1)(?5)){0,126}|\\[(?:(?>IPv6:(?>([a-f0-9]{1,4})(?>:(?6)){7}' +
				'|(?!(?:.*[a-f0-9][:\\]]){8,})((?6)(?>:(?6)){0,6})?::(?7)?))|(?>(?>IPv6:(?>(?6)(?>:(?6)){5}:' +
				'|(?!(?:.*[a-f0-9]:){6,})(?8)?::(?>((?6)(?>:(?6)){0,4}):)?))?(25[0-5]|2[0-4][0-9]|1[0-9]{2}' +
				'|[1-9]?[0-9])(?>\\.(?9)){3}))\\])(?1)$/isD'),
			var_address_mutated.clone(),
		])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('html5'))) {
		return (rt.call_function('preg_match', [
			rt.new_string("/^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}" +
				'[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/sD'),
			var_address_mutated.clone(),
		])).to_bool()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('eai'))) {
		return (rt.call_function('preg_match', [
			rt.new_string(
				"/^[-\\p{L}\\p{N}\\p{M}.!#$%&'*+\\/=?^_`{|}~]+@[\\p{L}\\p{N}\\p{M}](?:[\\p{L}\\p{N}\\p{M}-]{0,61}" +
				'[\\p{L}\\p{N}\\p{M}])?(?:\\.[\\p{L}\\p{N}\\p{M}]' +
				'(?:[-\\p{L}\\p{N}\\p{M}]{0,61}[\\p{L}\\p{N}\\p{M}])?)*$/usD'),
			var_address_mutated.clone(),
		])).to_bool()
	} else {
		return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('filter_var', [
			var_address_mutated.clone(),
			rt.get_constant('FILTER_VALIDATE_EMAIL'),
		]), rt.new_bool(false))))
	}
	return false
}

fn Class_PHPMailer_PHPMailer_PHPMailer.idnsupported() bool {
	return rt.is_true(rt.call_function('function_exists', [rt.new_string('idn_to_ascii')]))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')]))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) punyencodeaddress(var_address rt.PhpVal) string {
	mut var_address_mutated := var_address
	mut var_pos := rt.call_function('strrpos', [var_address_mutated.clone(),
		rt.new_string('@')])
	if !(!rt.is_true(this.CharSet))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos))))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.idnsupported()) {
		mut var_domain := rt.call_function('substr', [var_address_mutated.clone(),
			rt.pre_inc(var_pos)])
		if this.has8bitchars(var_domain.clone())
			&& rt.is_true(rt.call_function('mb_check_encoding', [var_domain.clone(), this.CharSet])) {
			var_domain = rt.call_function('mb_convert_encoding', [
				var_domain.clone(),
				Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.charset_utf8(),
				this.CharSet])
			mut var_errorcode := rt.new_int(0)
			if rt.is_true(rt.call_function('defined', [
				rt.new_string('INTL_IDNA_VARIANT_UTS46'),
			]))
			{
				mut var_punycode := rt.call_function('idn_to_ascii', [
					var_domain.clone(),
					rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('IDNA_DEFAULT'),
						rt.get_constant('IDNA_USE_STD3_RULES')), rt.get_constant('IDNA_CHECK_BIDI')),
						rt.get_constant('IDNA_CHECK_CONTEXTJ')),
						rt.get_constant('IDNA_NONTRANSITIONAL_TO_ASCII')),
					rt.get_constant('INTL_IDNA_VARIANT_UTS46')])
			} else if rt.is_true(rt.call_function('defined', [
				rt.new_string('INTL_IDNA_VARIANT_2003'),
			]))
			{
				var_punycode = rt.call_function('idn_to_ascii', [
					var_domain.clone(), var_errorcode.clone(),
					rt.get_constant('INTL_IDNA_VARIANT_2003')])
			} else {
				var_punycode = rt.call_function('idn_to_ascii', [
					var_domain.clone(), var_errorcode.clone()])
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_punycode)))) {
				return
					(rt.call_function('substr', [var_address_mutated.clone(), rt.new_int(0), var_pos.clone()])).str() +
					var_punycode.str()
			}
		}
	}
	return var_address_mutated.str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) send() bool {
	if !(this.presend()) {
		return false
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return this.postsend()
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_1.clone()
		this.mailHeader = ''
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
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
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) presend() bool {
	if rt.is_true(rt.identical(rt.new_string('smtp'), this.Mailer))
		|| (rt.is_true(rt.identical(rt.new_string('mail'), this.Mailer))
		&& rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80000)))
		|| rt.is_true(rt.identical(rt.call_function('stripos', [rt.get_constant('PHP_OS'), rt.new_string('WIN')]), rt.new_int(0)))) {
		Class_PHPMailer_PHPMailer_PHPMailer.setle(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf())
	} else {
		Class_PHPMailer_PHPMailer_PHPMailer.setle(rt.get_constant('PHP_EOL'))
	}
	if rt.is_true(rt.identical(rt.new_string('mail'), this.Mailer))
		&& (rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70000)))
		&& rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70017))))
		|| (rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70100)))
		&& rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70103))))
		&& rt.is_true(rt.identical(rt.call_function('ini_get', [rt.new_string('mail.add_x_header')]), rt.new_string('1')))
		&& rt.is_true(rt.identical(rt.call_function('stripos', [rt.get_constant('PHP_OS'), rt.new_string('WIN')]), rt.new_int(0))) {
		rt.call_function('trigger_error', [
			Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('buggy_php')),
			rt.get_constant('E_USER_WARNING'),
		])
	}
	this.error_count = 0
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.mailHeader = ''
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.charset_utf8(), rt.new_string(this.CharSet.to_string().to_lower())))
		&& this.anyaddresshasunicodelocalpart(this.RecipientsQueue)
		|| this.anyaddresshasunicodelocalpart(rt.func_array_keys(this.all_recipients))
		|| this.anyaddresshasunicodelocalpart(this.ReplyToQueue)
		|| this.addresshasunicodelocalpart(this.From) {
		this.UseSMTPUTF8 = true
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut iter_4 :=
		rt.call_function('array_merge', [this.RecipientsQueue, this.ReplyToQueue]).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_params := item_4.val
		if !(this.UseSMTPUTF8) {
			var_params.array_set(1, this.punyencodeaddress(var_params.array_get(rt.new_int(1))))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		rt.call_function('call_user_func_array', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_PHPMailer',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'addAnAddress' },
			]),
			var_params.clone(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if this.to.array_count() + this.cc.array_count() + this.bcc.array_count() < 1 {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('provide_address')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut iter_5 := rt.create_array([rt.ArrayItem{ key: none, val: 'From' },
		rt.ArrayItem{ key: none, val: 'Sender' }, rt.ArrayItem{ key: none, val: 'ConfirmReadingTo' }]).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_address_kind := item_5.val
		if rt.is_true(rt.identical(rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer',
			[]string{}, &this), '{"nodeType":"Expr_Variable","line":1743,"name":"address_kind"}'),
			rt.new_null()))
		{
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1744,"name":"address_kind"}',
				rt.new_string(''))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			continue
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1747,"name":"address_kind"}', rt.new_string(rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer',
			[]string{}, &this), '{"nodeType":"Expr_Variable","line":1747,"name":"address_kind"}').trim_space()))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if !rt.is_true(rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{},
			&this), '{"nodeType":"Expr_Variable","line":1748,"name":"address_kind"}')) {
			continue
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":1751,"name":"address_kind"}', this.punyencodeaddress(rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer',
			[]string{}, &this), '{"nodeType":"Expr_Variable","line":1751,"name":"address_kind"}')))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer',
			[]string{}, &this), '{"nodeType":"Expr_Variable","line":1752,"name":"address_kind"}'))))))
		{
			mut var_error_message := rt.call_function('sprintf', [
				rt.new_string('%s (%s): %s'),
				Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')),
				var_address_kind.clone(),
				rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this),
					'{"nodeType":"Expr_Variable","line":1757,"name":"address_kind"}'),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			this.seterror(var_error_message.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			this.edebug(var_error_message.clone())
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			if rt.is_true(this.exceptions) {
				rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
					create_phpmailer_phpmailer_exception(var_error_message.clone())))
				if rt.has_exception() {
					unsafe {
						goto catch_label_2
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
			return false
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if this.alternativeexists() {
		this.ContentType = Class_PHPMailer_PHPMailer_static.content_type_multipart_alternative()
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.setmessagetype()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.AllowEmpty)))) && !rt.is_true(this.Body) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('empty_message')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.Subject = this.Subject.trim_space()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.MIMEHeader = rt.new_string('')
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.MIMEBody = this.createbody()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut var_tempheaders := this.MIMEHeader
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.MIMEHeader = this.createheader()
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	this.MIMEHeader = rt.concat(this.MIMEHeader, var_tempheaders)
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.identical(rt.new_string('mail'), this.Mailer)) {
		if this.to.array_count() > 0 {
			this.mailHeader = rt.concat(this.mailHeader, this.addrappend(rt.new_string('To'),
				this.to))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		} else {
			this.mailHeader = rt.concat(this.mailHeader, this.headerline(rt.new_string('To'),
				rt.new_string('undisclosed-recipients:;')))
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		this.mailHeader = rt.concat(this.mailHeader, this.headerline(rt.new_string('Subject'),
			rt.new_string(this.encodeheader(rt.new_string(this.secureheader(rt.new_string(this.Subject))), ''))))
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if !(!rt.is_true(this.DKIM_domain)) && !(!rt.is_true(this.DKIM_selector))
		&& !(!rt.is_true(this.DKIM_private_string))
		|| (!(!rt.is_true(this.DKIM_private))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.ispermittedpath(this.DKIM_private))
		&& rt.is_true(rt.call_function('file_exists', [this.DKIM_private]))) {
		mut var_header_dkim := this.dkim_add(rt.new_string((this.MIMEHeader).str() + this.mailHeader),
			rt.new_string(this.encodeheader(rt.new_string(this.secureheader(rt.new_string(this.Subject))), '')),
			this.MIMEBody)
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
		this.MIMEHeader =
			(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(this.MIMEHeader)).str() + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
			(Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_header_dkim.clone())).str() +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return true
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_2.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) postsend() bool {
	mut switch_val_3 := this.Mailer
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('sendmail')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('qmail'))) {
		return this.sendmailsend(this.MIMEHeader, this.MIMEBody)
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('smtp'))) {
		return this.smtpsend(this.MIMEHeader, this.MIMEBody)
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('mail'))) {
		return this.mailsend(this.MIMEHeader, this.MIMEBody)
	} else {
		mut var_sendMethod := rt.new_string(this.Mailer + 'Send')
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		if rt.is_true(rt.call_function('method_exists', [
			rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this),
			var_sendMethod.clone(),
		]))
		{
			return (rt.call_method(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this),
				var_sendMethod, [this.MIMEHeader, this.MIMEBody])).to_bool()
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		return this.mailsend(this.MIMEHeader, this.MIMEBody)
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_3.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(rt.identical(this.Mailer, rt.new_string('smtp')))
			&& rt.is_true(rt.equal(this.SMTPKeepAlive, rt.new_bool(true)))
			&& rt.is_true(rt.call_method(this.smtp, 'connected', []rt.PhpVal{})) {
			rt.call_method(this.smtp, 'reset', []rt.PhpVal{})
		}
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) sendmailsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
	if rt.is_true(rt.identical(this.Mailer, rt.new_string('qmail'))) {
		this.edebug(rt.new_string('Sending with qmail'))
	} else {
		this.edebug(rt.new_string('Sending with sendmail'))
	}
	var_header_mutated = rt.new_string(
		(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(var_header_mutated.clone())).str() + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
	mut var_sendmail_from_value := rt.call_function('ini_get', [
		rt.new_string('sendmail_from'),
	])
	if !rt.is_true(this.Sender) && !(!rt.is_true(var_sendmail_from_value)) {
		this.Sender = rt.call_function('ini_get', [rt.new_string('sendmail_from')])
	}
	mut var_sendmailArgs := rt.new_array()
	if !(!rt.is_true(this.Sender))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(this.Sender))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.isshellsafe(this.Sender)) {
		var_sendmailArgs.array_push('-f' + (this.Sender).str())
	}
	if rt.is_true(rt.new_bool(this.Mailer != 'qmail')) {
		var_sendmailArgs.array_push('-i')
		var_sendmailArgs.array_push('-t')
	}
	mut var_resultArgs := rt.new_string((if !rt.is_true(var_sendmailArgs) {
		''
	} else {
		' ' + (rt.call_function('implode', [rt.new_string(' '), var_sendmailArgs.clone()])).str()
	}).str())
	mut var_sendmail := rt.new_string((rt.call_function('escapeshellcmd', [this.Sendmail])).str() +
		var_resultArgs.str().trim_space())
	this.edebug(rt.new_string('Sendmail path: ' + (this.Sendmail).str()))
	this.edebug(rt.new_string('Sendmail command: ' + var_sendmail.str()))
	this.edebug(rt.new_string('Envelope sender: ' + (this.Sender).str()))
	this.edebug(rt.new_string('Headers: ${var_header.to_string()}'))
	if rt.is_true(this.SingleTo) {
		mut iter_6 := this.SingleToArray.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_toAddr := item_6.val
			mut var_mail := rt.call_function('popen', [var_sendmail.clone(),
				rt.new_string('w')])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_mail)))) {
				rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('execute'))).str() +
					(this.Sendmail).str(),
					Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
			}
			this.edebug(rt.new_string('To: ${var_toAddr.to_string()}'))
			rt.call_function('fwrite', [var_mail.clone(),
				rt.new_string('To: ' + var_toAddr.str() + '\n')])
			rt.call_function('fwrite', [var_mail.clone(), var_header_mutated.clone()])
			rt.call_function('fwrite', [var_mail.clone(), var_body_mutated.clone()])
			mut var_result := rt.call_function('pclose', [var_mail.clone()])
			mut var_addrinfo := Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(var_toAddr.clone(),
				rt.new_null(), this.CharSet)
			mut iter_7 := var_addrinfo.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_addr := item_7.val
				this.docallback(rt.identical(var_result, rt.new_int(0)), rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_addr.array_get(rt.new_string('address')) },
						rt.ArrayItem{ key: none, val: var_addr.array_get(rt.new_string('name')) },
					]) },
				]), this.cc, this.bcc, rt.new_string(this.Subject), var_body_mutated.clone(),
					this.From, rt.new_array())
			}
			this.edebug(rt.new_string('Result: ' +
				if rt.is_true(rt.identical(var_result, rt.new_int(0))) { 'true' } else { 'false' }))
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_result)))) {
				rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('execute'))).str() +
					(this.Sendmail).str(),
					Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
			}
		}
	} else {
		mut var_mail := rt.call_function('popen', [var_sendmail.clone(),
			rt.new_string('w')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_mail)))) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('execute'))).str() +
				(this.Sendmail).str(),
				Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
		}
		rt.call_function('fwrite', [var_mail.clone(), var_header_mutated.clone()])
		rt.call_function('fwrite', [var_mail.clone(), var_body_mutated.clone()])
		mut var_result := rt.call_function('pclose', [var_mail.clone()])
		this.docallback(rt.identical(var_result, rt.new_int(0)), this.to, this.cc, this.bcc,
			rt.new_string(this.Subject), var_body_mutated.clone(), this.From, rt.new_array())
		this.edebug(rt.new_string('Result: ' +
			if rt.is_true(rt.identical(var_result, rt.new_int(0))) { 'true' } else { 'false' }))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_result)))) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('execute'))).str() +
				(this.Sendmail).str(),
				Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
		}
	}
	return true
}

fn Class_PHPMailer_PHPMailer_PHPMailer.isshellsafe(var_string rt.PhpVal) bool {
	mut var_string_mutated := var_string
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('escapeshellarg')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('escapeshellcmd')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('escapeshellcmd', [var_string_mutated.clone()]), var_string_mutated))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('escapeshellarg', [var_string_mutated.clone()]), rt.create_array([rt.ArrayItem{
		key: none
		val: "'${var_string.to_string()}'"
	}, rt.ArrayItem{ key: none, val: "\"${var_string.to_string()}\"" }])]))))) {
		return false
	}
	mut var_length := rt.new_int(var_string_mutated.clone().to_string().len)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_length))) { break
		 }
		mut var_c := var_string_mutated.array_get(var_i)
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('ctype_alnum', [var_c.clone()])))))
			&& rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string('@_-.'), var_c.clone()]), rt.new_bool(false))) {
			return false
		}
		rt.pre_inc(var_i)
	}
	return true
}

fn Class_PHPMailer_PHPMailer_PHPMailer.ispermittedpath(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	return !(rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#^[a-z][a-z\\d+.-]*://#i'),
		var_path_mutated.clone(),
	])))
}

fn Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.ispermittedpath(var_path_mutated.clone()))))) {
		return false
	}
	mut var_readable := rt.call_function('is_file', [var_path_mutated.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [
		var_path_mutated.clone(),
		rt.new_string('\\\\'),
	]), rt.new_int(0)))))
	{
		var_readable = rt.new_bool(rt.is_true(var_readable)
			&& rt.is_true(rt.call_function('is_readable', [var_path_mutated.clone()])))
	}
	return var_readable.to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) mailsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
	var_header_mutated = rt.new_string(
		(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(var_header_mutated.clone())).str() + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
	mut var_toArr := rt.new_array()
	mut iter_8 := this.to.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_toaddr := item_8.val
		var_toArr.array_push(this.addrformat(var_toaddr.clone()))
	}
	mut var_to := rt.new_string(rt.call_function('implode', [
		rt.new_string(', '), var_toArr.clone()]).to_string().trim_space())
	if rt.is_true(rt.identical(var_to, rt.new_string(''))) {
		var_to = rt.new_string('undisclosed-recipients:;')
	}
	mut var_params := rt.new_null()
	mut var_sendmail_from_value := rt.call_function('ini_get', [
		rt.new_string('sendmail_from'),
	])
	if !rt.is_true(this.Sender) && !(!rt.is_true(var_sendmail_from_value)) {
		this.Sender = rt.call_function('ini_get', [rt.new_string('sendmail_from')])
	}
	if !(!rt.is_true(this.Sender))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(this.Sender)) {
		mut var_phpmailer_path := rt.call_function('ini_get', [
			rt.new_string('sendmail_path'),
		])
		if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.isshellsafe(this.Sender))
			&& rt.is_true(rt.identical(rt.call_function('strpos', [var_phpmailer_path.clone(), rt.new_string(' -f')]), rt.new_bool(false))) {
			var_params = rt.call_function('sprintf', [rt.new_string('-f%s'), this.Sender])
		}
		mut var_old_from := rt.call_function('ini_get', [rt.new_string('sendmail_from')])
		rt.call_function('ini_set', [rt.new_string('sendmail_from'), this.Sender])
	}
	mut var_result := rt.new_bool(false)
	if rt.is_true(this.SingleTo) && var_toArr.clone().array_count() > 1 {
		mut iter_9 := var_toArr.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_toAddr := item_9.val
			var_result = this.mailpassthru(var_toAddr.clone(), rt.new_string(this.Subject),
				var_body_mutated.clone(), var_header_mutated.clone(), var_params.clone())
			mut var_addrinfo := Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(var_toAddr.clone(),
				rt.new_null(), this.CharSet)
			mut iter_10 := var_addrinfo.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_addr := item_10.val
				this.docallback(var_result.clone(), rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_addr.array_get(rt.new_string('address')) },
						rt.ArrayItem{ key: none, val: var_addr.array_get(rt.new_string('name')) },
					]) },
				]), this.cc, this.bcc, rt.new_string(this.Subject), var_body_mutated.clone(),
					this.From, rt.new_array())
			}
		}
	} else {
		var_result = this.mailpassthru(var_to.clone(), rt.new_string(this.Subject),
			var_body_mutated.clone(), var_header_mutated.clone(), var_params.clone())
		this.docallback(var_result.clone(), this.to, this.cc, this.bcc,
			rt.new_string(this.Subject), var_body_mutated.clone(), this.From, rt.new_array())
	}
	if !var_old_from.is_null() {
		rt.call_function('ini_set', [rt.new_string('sendmail_from'),
			var_old_from.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('instantiate')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtpinstance() rt.PhpVal {
	if !(this.smtp.is_object()) {
		this.smtp = create_phpmailer_phpmailer_smtp()
	}
	return this.smtp
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setsmtpinstance(mut var_smtp Class_PHPMailer_PHPMailer_SMTP) rt.PhpVal {
	this.smtp = var_smtp
	return this.smtp
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setsmtpxclientattribute(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_name_mutated.clone(),
		rt.get_static_prop('PHPMailer_PHPMailer_SMTP',
			'xclient_allowed_attributes')])))))
	{
		return false
	}
	if this.SMTPXClient.array_isset(var_name_mutated)
		&& rt.is_true(rt.identical(var_value_mutated, rt.new_null())) {
		this.SMTPXClient.array_unset(var_name_mutated)
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_value_mutated, rt.new_null())))) {
		this.SMTPXClient.array_set(var_name_mutated, var_value_mutated.clone())
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtpxclientattributes() rt.PhpVal {
	return this.SMTPXClient
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
	var_header_mutated = rt.new_string(
		(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(var_header_mutated.clone())).str() + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
	mut var_bad_rcpt := rt.new_array()
	if !(this.smtpconnect(this.SMTPOptions)) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('smtp_connect_failed')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
	}
	if this.UseSMTPUTF8
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'getServerExt', [rt.new_string('SMTPUTF8')]))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('no_smtputf8')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
	}
	if rt.is_true(rt.identical(rt.new_string(''), this.Sender)) {
		mut var_smtp_from := this.From
	} else {
		var_smtp_from = this.Sender
	}
	if rt.is_true(rt.new_int(this.SMTPXClient.array_count())) {
		rt.call_method(this.smtp, 'xclient', [this.SMTPXClient])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'mail', [
		var_smtp_from.clone()])))))
	{
		this.seterror(rt.new_string(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('from_failed'))).str() + var_smtp_from.str() +
			' : ' +(rt.call_function('implode', [rt.new_string(','), rt.call_method(this.smtp, 'getError', []rt.PhpVal{})])).str()))
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(this.ErrorInfo,
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
	}
	mut var_callbacks := rt.new_array()
	mut iter_11 := rt.create_array([rt.ArrayItem{ key: none, val: this.to },
		rt.ArrayItem{ key: none, val: this.cc }, rt.ArrayItem{ key: none, val: this.bcc }]).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_togroup := item_11.val
		mut iter_12 := var_togroup.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_to := item_12.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'recipient', [
				var_to.array_get(rt.new_int(0)),
				this.dsn,
			])))))
			{
				mut var_error := rt.call_method(this.smtp, 'getError', []rt.PhpVal{})
				var_bad_rcpt.array_push(rt.create_array([
					rt.ArrayItem{ key: 'to', val: var_to.array_get(rt.new_int(0)) },
					rt.ArrayItem{ key: 'error', val: var_error.array_get(rt.new_string('detail')) },
				]))
				mut var_isSent := rt.new_bool(false)
			} else {
				var_isSent = rt.new_bool(true)
			}
			var_callbacks.array_push(rt.create_array([
				rt.ArrayItem{ key: 'issent', val: var_isSent },
				rt.ArrayItem{ key: 'to', val: var_to.array_get(rt.new_int(0)) },
				rt.ArrayItem{ key: 'name', val: var_to.array_get(rt.new_int(1)) },
			]))
		}
	}
	if this.all_recipients.array_count() > var_bad_rcpt.clone().array_count()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'data', [rt.new_string(var_header_mutated.str() + var_body_mutated.str())]))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('data_not_accepted')),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
	}
	mut var_smtp_transaction_id := rt.call_method(this.smtp, 'getLastTransactionID', []rt.PhpVal{})
	if rt.is_true(this.SMTPKeepAlive) {
		rt.call_method(this.smtp, 'reset', []rt.PhpVal{})
	} else {
		rt.call_method(this.smtp, 'quit', []rt.PhpVal{})
		rt.call_method(this.smtp, 'close', []rt.PhpVal{})
	}
	mut iter_13 := var_callbacks.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_cb := item_13.val
		this.docallback(var_cb.array_get(rt.new_string('issent')), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: none, val: var_cb.array_get(rt.new_string('to')) },
				rt.ArrayItem{ key: none, val: var_cb.array_get(rt.new_string('name')) },
			]) },
		]), rt.new_array(), rt.new_array(), rt.new_string(this.Subject), var_body_mutated.clone(),
			this.From, rt.create_array([
			rt.ArrayItem{ key: 'smtp_transaction_id', val: var_smtp_transaction_id },
		]))
	}
	if var_bad_rcpt.clone().array_count() > 0 {
		mut var_errstr := rt.new_string('')
		mut iter_14 := var_bad_rcpt.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_bad := item_14.val
			var_errstr = rt.concat(var_errstr, rt.new_string(
				(var_bad.array_get(rt.new_string('to'))).str() + ': ' +
				(var_bad.array_get(rt.new_string('error'))).str()))
		}
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('recipients_failed'))).str() +
			var_errstr.str(),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_continue())))
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpconnect(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
	if rt.is_true(rt.identical(rt.new_null(), this.smtp)) {
		this.smtp = this.getsmtpinstance()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_options_mutated)) {
		var_options_mutated = this.SMTPOptions
	}
	if rt.is_true(rt.call_method(this.smtp, 'connected', []rt.PhpVal{})) {
		return true
	}
	rt.call_method(this.smtp, 'setTimeout', [this.Timeout])
	rt.call_method(this.smtp, 'setDebugLevel', [this.SMTPDebug])
	rt.call_method(this.smtp, 'setDebugOutput', [rt.new_string(this.Debugoutput)])
	rt.call_method(this.smtp, 'setVerp', [this.do_verp])
	rt.call_method(this.smtp, 'setSMTPUTF8', [rt.new_bool(this.UseSMTPUTF8)])
	if rt.is_true(rt.identical(this.Host, rt.new_null())) {
		this.Host = 'localhost'
	}
	mut var_hosts := rt.call_function('explode', [rt.new_string(';'),
		rt.new_string(this.Host)])
	mut var_lastexception := rt.new_null()
	mut iter_15 := var_hosts.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_hostentry := item_15.val
		mut var_hostinfo := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^(?:(ssl|tls):\\/\\/)?(.+?)(?::(\\d+))?$/'),
			rt.new_string(var_hostentry.clone().to_string().trim_space()),
			var_hostinfo.clone(),
		])))))
		{
			this.edebug(rt.new_string(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_hostentry'))).str() +
				' ' + var_hostentry.clone().to_string().trim_space()))
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.isvalidhost(var_hostinfo.array_get(rt.new_int(2))))))) {
			this.edebug(rt.new_string(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_host'))).str() +
				' ' + (var_hostinfo.array_get(rt.new_int(2))).str()))
			continue
		}
		mut var_prefix := rt.new_string('')
		mut var_secure := this.SMTPSecure
		mut var_tls := rt.identical(Class_PHPMailer_PHPMailer_static.encryption_starttls(),
			this.SMTPSecure)
		if rt.is_true(rt.identical(rt.new_string('ssl'), var_hostinfo.array_get(rt.new_int(1))))
			|| (rt.is_true(rt.identical(rt.new_string(''), var_hostinfo.array_get(rt.new_int(1))))
			&& rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encryption_smtps(), this.SMTPSecure))) {
			var_prefix = rt.new_string('ssl://')
			var_tls = rt.new_bool(false)
			var_secure = Class_PHPMailer_PHPMailer_static.encryption_smtps()
		} else if rt.is_true(rt.identical(rt.new_string('tls'),
			var_hostinfo.array_get(rt.new_int(1))))
		{
			var_tls = rt.new_bool(true)
			var_secure = Class_PHPMailer_PHPMailer_static.encryption_starttls()
		}
		mut var_sslext := rt.call_function('defined', [
			rt.new_string('OPENSSL_ALGO_SHA256'),
		])
		if rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encryption_starttls(), var_secure))
			|| rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encryption_smtps(), var_secure)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var_sslext)))) {
				rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('extension_missing'))).str() + 'openssl',
					Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
			}
		}
		mut var_host := var_hostinfo.array_get(rt.new_int(2))
		mut var_port := this.Port
		if rt.is_true(rt.new_bool(var_hostinfo.clone().array_isset(rt.new_int(3))))
			&& var_hostinfo.array_get(rt.new_int(3)).is_long()
			|| var_hostinfo.array_get(rt.new_int(3)).is_double()
			&& rt.is_true(rt.greater(var_hostinfo.array_get(rt.new_int(3)), rt.new_int(0)))
			&& rt.is_true(rt.less(var_hostinfo.array_get(rt.new_int(3)), rt.new_int(65536))) {
			var_port = rt.new_int((var_hostinfo.array_get(rt.new_int(3))).to_i64())
		}
		if rt.is_true(rt.call_method(this.smtp, 'connect', [
			rt.new_string(var_prefix.str() + var_host.str()),
			var_port.clone(),
			this.Timeout,
			var_options_mutated.clone(),
		]))
		{
			if rt.is_true(this.Helo) {
				mut var_hello := this.Helo
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			} else {
				var_hello = rt.new_string(this.serverhostname())
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			rt.call_method(this.smtp, 'hello', [var_hello.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			if rt.is_true(this.SMTPAutoTLS) && rt.is_true(rt.new_bool(this.Host != 'localhost'))
				&& rt.is_true(var_sslext)
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_secure, rt.new_string('ssl')))))
				&& rt.is_true(rt.call_method(this.smtp, 'getServerExt', [rt.new_string('STARTTLS')])) {
				var_tls = rt.new_bool(true)
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			if rt.is_true(var_tls) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'startTLS',
					[]rt.PhpVal{})))))
				{
					mut var_message := this.getsmtperrormessage(rt.new_string('connect_host'))
					if rt.has_exception() {
						unsafe {
							goto catch_label_4
						}
					}
					rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
						create_phpmailer_phpmailer_exception(var_message.clone())))
					if rt.has_exception() {
						unsafe {
							goto catch_label_4
						}
					}
				}
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
				rt.call_method(this.smtp, 'hello', [var_hello.clone()])
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			if rt.is_true(this.SMTPAuth)
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.smtp, 'authenticate', [this.Username, this.Password, this.AuthType, this.oauth]))))) {
				rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
					create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('authenticate')))))
				if rt.has_exception() {
					unsafe {
						goto catch_label_4
					}
				}
			}
			if rt.has_exception() {
				unsafe {
					goto catch_label_4
				}
			}
			return true
			unsafe {
				goto end_label_4
			}
			catch_label_4:
			mut var_e_4 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_4, 'PHPMailer_PHPMailer_Exception') {
				mut var_exc := var_e_4.clone()
				var_lastexception = var_exc
				this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
				rt.call_method(this.smtp, 'quit', []rt.PhpVal{})
				unsafe {
					goto end_label_4
				}
			} else {
				rt.throw_exception(var_e_4)
				unsafe {
					goto end_label_4
				}
			}

			end_label_4:
		}
	}
	rt.call_method(this.smtp, 'close', []rt.PhpVal{})
	if rt.is_true(this.exceptions)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_lastexception)))) {
		rt.throw_exception(var_lastexception)
	}
	if rt.is_true(this.exceptions) {
		mut var_message := this.getsmtperrormessage(rt.new_string('connect_host'))
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
			create_phpmailer_phpmailer_exception(var_message.clone())))
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpclose() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.smtp))))
		&& rt.is_true(rt.call_method(this.smtp, 'connected', []rt.PhpVal{})) {
		rt.call_method(this.smtp, 'quit', []rt.PhpVal{})
		rt.call_method(this.smtp, 'close', []rt.PhpVal{})
	}
}

fn Class_PHPMailer_PHPMailer_PHPMailer.setlanguage(langcode string, lang_path string) rt.PhpVal {
	mut langcode_mutated := langcode
	mut lang_path_mutated := lang_path
	mut var_renamed_langcodes := rt.create_array([
		rt.ArrayItem{ key: 'br', val: 'pt_br' },
		rt.ArrayItem{ key: 'cz', val: 'cs' },
		rt.ArrayItem{ key: 'dk', val: 'da' },
		rt.ArrayItem{ key: 'no', val: 'nb' },
		rt.ArrayItem{ key: 'se', val: 'sv' },
		rt.ArrayItem{ key: 'rs', val: 'sr' },
		rt.ArrayItem{ key: 'tg', val: 'tl' },
		rt.ArrayItem{ key: 'am', val: 'hy' },
	])
	if rt.is_true(rt.new_bool(var_renamed_langcodes.clone().array_isset(rt.new_string(langcode_mutated).clone()))) {
		langcode_mutated = (var_renamed_langcodes.array_get(rt.new_string(langcode_mutated))).str()
	}
	mut var_PHPMAILER_LANG := rt.create_array([
		rt.ArrayItem{ key: 'authenticate', val: 'SMTP Error: Could not authenticate.' },
		rt.ArrayItem{
			key: 'buggy_php'
			val:
				'Your version of PHP is affected by a bug that may result in corrupted messages.' +
				' To fix it, switch to sending using SMTP, disable the mail.add_x_header option in' +
				' your php.ini, switch to MacOS or Linux, or upgrade your PHP to version 7.0.17+ or 7.1.3+.'
		},
		rt.ArrayItem{ key: 'connect_host', val: 'SMTP Error: Could not connect to SMTP host.' },
		rt.ArrayItem{ key: 'data_not_accepted', val: 'SMTP Error: data not accepted.' },
		rt.ArrayItem{ key: 'empty_message', val: 'Message body empty' },
		rt.ArrayItem{ key: 'encoding', val: 'Unknown encoding: ' },
		rt.ArrayItem{ key: 'execute', val: 'Could not execute: ' },
		rt.ArrayItem{ key: 'extension_missing', val: 'Extension missing: ' },
		rt.ArrayItem{ key: 'file_access', val: 'Could not access file: ' },
		rt.ArrayItem{ key: 'file_open', val: 'File Error: Could not open file: ' },
		rt.ArrayItem{ key: 'from_failed', val: 'The following From address failed: ' },
		rt.ArrayItem{ key: 'instantiate', val: 'Could not instantiate mail function.' },
		rt.ArrayItem{ key: 'invalid_address', val: 'Invalid address: ' },
		rt.ArrayItem{ key: 'invalid_header', val: 'Invalid header name or value' },
		rt.ArrayItem{ key: 'invalid_hostentry', val: 'Invalid hostentry: ' },
		rt.ArrayItem{ key: 'invalid_host', val: 'Invalid host: ' },
		rt.ArrayItem{ key: 'mailer_not_supported', val: ' mailer is not supported.' },
		rt.ArrayItem{
			key: 'provide_address'
			val: 'You must provide at least one recipient email address.'
		},
		rt.ArrayItem{ key: 'recipients_failed', val: 'SMTP Error: The following recipients failed: ' },
		rt.ArrayItem{ key: 'signing', val: 'Signing Error: ' },
		rt.ArrayItem{ key: 'smtp_code', val: 'SMTP code: ' },
		rt.ArrayItem{ key: 'smtp_code_ex', val: 'Additional SMTP info: ' },
		rt.ArrayItem{ key: 'smtp_connect_failed', val: 'SMTP connect() failed.' },
		rt.ArrayItem{ key: 'smtp_detail', val: 'Detail: ' },
		rt.ArrayItem{ key: 'smtp_error', val: 'SMTP server error: ' },
		rt.ArrayItem{ key: 'variable_set', val: 'Cannot set or reset variable: ' },
		rt.ArrayItem{
			key: 'no_smtputf8'
			val: 'Server does not support SMTPUTF8 needed to send to Unicode addresses'
		},
		rt.ArrayItem{ key: 'imap_recommended', val:
			'Using simplified address parser is not recommended. ' +
			'Install the PHP IMAP extension for full RFC822 parsing.' },
		rt.ArrayItem{ key: 'deprecated_argument', val: 'Deprecated Argument: ' },
	])
	if lang_path_mutated == '' {
		lang_path_mutated = (rt.call_function('dirname', [rt.new_string(@DIR)])).str() +
			(rt.get_constant('DIRECTORY_SEPARATOR')).str() + 'language' +
			(rt.get_constant('DIRECTORY_SEPARATOR')).str()
	}
	mut var_foundlang := rt.new_bool(true)
	langcode_mutated = langcode_mutated.to_lower()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(?P<lang>[a-z]{2})(?P<script>_[a-z]{4})?(?P<country>_[a-z]{2})?$/'), rt.new_string(langcode_mutated).clone(), var_matches.clone()])))))
		&& rt.is_true(rt.new_bool(langcode_mutated != 'en')) {
		var_foundlang = rt.new_bool(false)
		langcode_mutated = 'en'
	}
	if rt.is_true(rt.new_bool('en' != langcode_mutated)) {
		mut var_langcodes := rt.new_array()
		if !(!rt.is_true(var_matches.array_get(rt.new_string('script'))))
			&& !(!rt.is_true(var_matches.array_get(rt.new_string('country')))) {
			var_langcodes.array_push((var_matches.array_get(rt.new_string('lang'))).str() +
				(var_matches.array_get(rt.new_string('script'))).str() +
				(var_matches.array_get(rt.new_string('country'))).str())
		}
		if !(!rt.is_true(var_matches.array_get(rt.new_string('country')))) {
			var_langcodes.array_push((var_matches.array_get(rt.new_string('lang'))).str() +
				(var_matches.array_get(rt.new_string('country'))).str())
		}
		if !(!rt.is_true(var_matches.array_get(rt.new_string('script')))) {
			var_langcodes.array_push((var_matches.array_get(rt.new_string('lang'))).str() +
				(var_matches.array_get(rt.new_string('script'))).str())
		}
		var_langcodes.array_push(var_matches.array_get(rt.new_string('lang')))
		mut var_foundFile := rt.new_bool(false)
		mut iter_16 := var_langcodes.iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_code := item_16.val
			mut var_lang_file := rt.new_string(lang_path_mutated + 'phpmailer.lang-' +
				var_code.str() + '.php')
			if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_lang_file.clone())) {
				var_foundFile = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.identical(var_foundFile, rt.new_bool(false))) {
			var_foundlang = rt.new_bool(false)
		} else {
			mut var_lines := rt.call_function('file', [var_lang_file.clone()])
			mut iter_17 := var_lines.iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_line := item_17.val
				mut var_matches := rt.new_array()
				if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\$PHPMAILER_LANG\\[\'([a-z\\d_]+)\'\\]\\s*=\\s*(["\'])(.+)*?\\2;/'), var_line.clone(), var_matches.clone()]))
					&& rt.is_true(rt.new_bool(var_PHPMAILER_LANG.clone().array_isset(var_matches.array_get(rt.new_int(1))))) {
					var_PHPMAILER_LANG.array_set(var_matches.array_get(rt.new_int(1)),
						(var_matches.array_get(rt.new_int(3))).str())
				}
			}
		}
	}
	rt.set_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language', var_PHPMAILER_LANG.clone())
	return var_foundlang.clone()
	return rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) gettranslations() rt.PhpVal {
	if !rt.is_true(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language')) {
		Class_PHPMailer_PHPMailer_PHPMailer.setlanguage()
	}
	return rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language')
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addrappend(var_type rt.PhpVal, var_addr rt.PhpVal) string {
	mut var_type_mutated := var_type
	mut var_addresses := rt.new_array()
	mut iter_18 := var_addr.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_address := item_18.val
		var_addresses.array_push(this.addrformat(var_address.clone()))
	}
	return var_type_mutated.str() + ': ' +
		(rt.call_function('implode', [rt.new_string(', '), var_addresses.clone()])).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addrformat(var_addr rt.PhpVal) string {
	if !(var_addr.array_isset(rt.new_int(1)))
		|| rt.is_true(rt.identical(var_addr.array_get(rt.new_int(1)), rt.new_string(''))) {
		return this.secureheader(var_addr.array_get(rt.new_int(0)))
	}
	return
		this.encodeheader(rt.new_string(this.secureheader(var_addr.array_get(rt.new_int(1)))), 'phrase') +
		' <' + this.secureheader(var_addr.array_get(rt.new_int(0))) + '>'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) wraptext(var_message rt.PhpVal, var_length rt.PhpVal, qp_mode bool) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_length_mutated := var_length
	if var_qp_mode {
		mut var_soft_break := rt.call_function('sprintf', [rt.new_string(' =%s'),
			rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')])
	} else {
		var_soft_break = rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')
	}
	mut var_is_utf8 := rt.identical(Class_PHPMailer_PHPMailer_static.charset_utf8(),
		rt.new_string(this.CharSet.to_string().to_lower()))
	mut var_lelen :=
		rt.new_int(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE').to_string().len)
	mut var_crlflen :=
		rt.new_int(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE').to_string().len)
	var_message_mutated =
		Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_message_mutated.clone())
	if rt.is_true(rt.identical(rt.call_function('substr', [var_message_mutated.clone(),
		rt.sub(rt.new_int(0), var_lelen)]), rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer',
		'LE')))
	{
		var_message_mutated = rt.call_function('substr', [var_message_mutated.clone(),
			rt.new_int(0), rt.sub(rt.new_int(0), var_lelen)])
	}
	mut var_lines := rt.call_function('explode', [
		rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
		var_message_mutated.clone(),
	])
	var_message_mutated = rt.new_string('')
	mut iter_19 := var_lines.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_line := item_19.val
		mut var_words := rt.call_function('explode', [rt.new_string(' '),
			var_line.clone()])
		mut var_buf := rt.new_string('')
		mut var_firstword := rt.new_bool(true)
		mut iter_20 := var_words.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_word := item_20.val
			if var_qp_mode
				&& rt.is_true(rt.greater(rt.new_int(var_word.clone().to_string().len), var_length_mutated)) {
				mut var_space_left := rt.sub(rt.sub(var_length_mutated,
					rt.new_int(var_buf.clone().to_string().len)), var_crlflen)
				if rt.is_true(rt.new_bool(!(rt.is_true(var_firstword)))) {
					if rt.is_true(rt.greater(var_space_left, rt.new_int(20))) {
						mut var_len := var_space_left.clone()
						if rt.is_true(var_is_utf8) {
							var_len = this.utf8charboundary(var_word.clone(), var_len.clone())
						} else if rt.is_true(rt.identical(rt.new_string('='), rt.call_function('substr', [
							var_word.clone(),
							rt.sub(var_len, rt.new_int(1)),
							rt.new_int(1),
						])))
						{
							rt.pre_dec(var_len)
						} else if rt.is_true(rt.identical(rt.new_string('='), rt.call_function('substr', [
							var_word.clone(),
							rt.sub(var_len, rt.new_int(2)),
							rt.new_int(1),
						])))
						{
							var_len = rt.sub(var_len, rt.new_int(2))
						}
						mut var_part := rt.call_function('substr', [
							var_word.clone(), rt.new_int(0), var_len.clone()])
						var_word = rt.call_function('substr', [
							var_word.clone(), var_len.clone()])
						var_buf = rt.concat(var_buf, rt.new_string(' ' + var_part.str()))
						var_message_mutated = rt.concat(var_message_mutated, rt.new_string(
							var_buf.str() +(rt.call_function('sprintf', [rt.new_string('=%s'), rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')])).str()))
					} else {
						var_message_mutated = rt.concat(var_message_mutated, rt.new_string(
							var_buf.str() + var_soft_break.str()))
					}
					var_buf = rt.new_string('')
				}
				for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_word, rt.new_string(''))))) {
					if rt.is_true(rt.less_equal(var_length_mutated, rt.new_int(0))) {
						break
					}
					var_len = var_length_mutated.clone()
					if rt.is_true(var_is_utf8) {
						var_len = this.utf8charboundary(var_word.clone(), var_len.clone())
					} else if rt.is_true(rt.identical(rt.new_string('='), rt.call_function('substr', [
						var_word.clone(),
						rt.sub(var_len, rt.new_int(1)),
						rt.new_int(1),
					])))
					{
						rt.pre_dec(var_len)
					} else if rt.is_true(rt.identical(rt.new_string('='), rt.call_function('substr', [
						var_word.clone(),
						rt.sub(var_len, rt.new_int(2)),
						rt.new_int(1),
					])))
					{
						var_len = rt.sub(var_len, rt.new_int(2))
					}
					var_part = rt.call_function('substr', [var_word.clone(),
						rt.new_int(0), var_len.clone()])
					var_word = rt.new_string((rt.call_function('substr', [
						var_word.clone(), var_len.clone()])).str())
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_word, rt.new_string(''))))) {
						var_message_mutated = rt.concat(var_message_mutated, rt.new_string(
							var_part.str() +(rt.call_function('sprintf', [rt.new_string('=%s'), rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')])).str()))
					} else {
						var_buf = var_part.clone()
					}
				}
			} else {
				mut var_buf_o := var_buf.clone()
				if rt.is_true(rt.new_bool(!(rt.is_true(var_firstword)))) {
					var_buf = rt.concat(var_buf, rt.new_string(' '))
				}
				var_buf = rt.concat(var_buf, var_word)
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_buf_o))))
					&& rt.is_true(rt.greater(rt.new_int(var_buf.clone().to_string().len), var_length_mutated)) {
					var_message_mutated = rt.concat(var_message_mutated, rt.new_string(
						var_buf_o.str() + var_soft_break.str()))
					var_buf = var_word.clone()
				}
			}
			var_firstword = rt.new_bool(false)
		}
		var_message_mutated = rt.concat(var_message_mutated, rt.new_string(var_buf.str() +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()))
	}
	return var_message_mutated.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) utf8charboundary(var_encodedText rt.PhpVal, var_maxLength rt.PhpVal) rt.PhpVal {
	mut var_foundSplitPos := rt.new_bool(false)
	mut var_lookBack := rt.new_int(3)
	for rt.is_true(rt.new_bool(!(rt.is_true(var_foundSplitPos)))) {
		mut var_lastChunk := rt.call_function('substr', [var_encodedText.clone(),
			rt.sub(var_maxLength, var_lookBack), var_lookBack.clone()])
		mut var_encodedCharPos := rt.call_function('strpos', [
			var_lastChunk.clone(), rt.new_string('=')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_encodedCharPos)))) {
			mut var_hex := rt.call_function('substr', [var_encodedText.clone(),
				rt.add(rt.add(rt.sub(var_maxLength, var_lookBack), var_encodedCharPos),
					rt.new_int(1)),
				rt.new_int(2)])
			mut var_dec := rt.call_function('hexdec', [var_hex.clone()])
			if rt.is_true(rt.less(var_dec, rt.new_int(128))) {
				if rt.is_true(rt.greater(var_encodedCharPos, rt.new_int(0))) {
					var_maxLength = rt.sub(var_maxLength, rt.sub(var_lookBack, var_encodedCharPos))
				}
				var_foundSplitPos = rt.new_bool(true)
			} else if rt.is_true(rt.greater_equal(var_dec, rt.new_int(192))) {
				var_maxLength = rt.sub(var_maxLength, rt.sub(var_lookBack, var_encodedCharPos))
				var_foundSplitPos = rt.new_bool(true)
			} else if rt.is_true(rt.less(var_dec, rt.new_int(192))) {
				var_lookBack = rt.add(var_lookBack, rt.new_int(3))
			}
		} else {
			var_foundSplitPos = rt.new_bool(true)
		}
	}
	return var_maxLength.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setwordwrap() {
	if rt.is_true(rt.less(this.WordWrap, rt.new_int(1))) {
		return
	}
	mut switch_val_4 := this.message_type
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('alt')))
		|| rt.is_true(rt.equal(switch_val_4, rt.new_string('alt_inline')))
		|| rt.is_true(rt.equal(switch_val_4, rt.new_string('alt_attach')))
		|| rt.is_true(rt.equal(switch_val_4, rt.new_string('alt_inline_attach'))) {
		this.AltBody = this.wraptext(this.AltBody, this.WordWrap, false)
	} else {
		this.Body = this.wraptext(this.Body, this.WordWrap, false)
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) createheader() rt.PhpVal {
	mut var_result := rt.new_string('')
	var_result = rt.concat(var_result, this.headerline(rt.new_string('Date'), if rt.is_true(rt.identical(rt.new_string(''),
		this.MessageDate))
	{
		Class_PHPMailer_PHPMailer_PHPMailer.rfcdate()
	} else {
		this.MessageDate
	}))
	if rt.is_true(rt.new_bool('mail' != this.Mailer)) {
		if rt.is_true(this.SingleTo) {
			mut iter_21 := this.to.iterator()
			for {
				item_21 := iter_21.next() or { break }
				mut var_toaddr := item_21.val
				this.SingleToArray.array_push(this.addrformat(var_toaddr.clone()))
			}
		} else if this.to.array_count() > 0 {
			var_result = rt.concat(var_result, this.addrappend(rt.new_string('To'), this.to))
		} else if this.cc.array_count() == 0 {
			var_result = rt.concat(var_result, this.headerline(rt.new_string('To'),
				rt.new_string('undisclosed-recipients:;')))
		}
	}
	var_result = rt.concat(var_result, this.addrappend(rt.new_string('From'), rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: none, val: this.From.to_string().trim_space() },
			rt.ArrayItem{ key: none, val: this.FromName },
		]) },
	])))
	if this.cc.array_count() > 0 {
		var_result = rt.concat(var_result, this.addrappend(rt.new_string('Cc'), this.cc))
	}
	if rt.is_true(rt.identical(rt.new_string('sendmail'), this.Mailer))
		|| rt.is_true(rt.identical(rt.new_string('qmail'), this.Mailer))
		|| rt.is_true(rt.identical(rt.new_string('mail'), this.Mailer))
		&& this.bcc.array_count() > 0 {
		var_result = rt.concat(var_result, this.addrappend(rt.new_string('Bcc'), this.bcc))
	}
	if this.ReplyTo.array_count() > 0 {
		var_result = rt.concat(var_result, this.addrappend(rt.new_string('Reply-To'), this.ReplyTo))
	}
	if rt.is_true(rt.new_bool('mail' != this.Mailer)) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Subject'),
			rt.new_string(this.encodeheader(rt.new_string(this.secureheader(rt.new_string(this.Subject))), ''))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.MessageID))))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string("/^<((([a-z\\d!#$%&'*+\\/=?^_`{|}~-]+(\\.[a-z\\d!#$%&'*+\\/=?^_`{|}~-]+)*)" + '|("(([\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F]|[\\x21\\x23-\\x5B\\x5D-\\x7E])' + '|(\\[\\x01-\\x09\\x0B\\x0C\\x0E-\\x7F]))*"))@(([a-z\\d!#$%&\'*+\\/=?^_`{|}~-]+' + "(\\.[a-z\\d!#$%&'*+\\/=?^_`{|}~-]+)*)|(\\[(([\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x7F]" + '|[\\x21-\\x5A\\x5E-\\x7E])|(\\[\\x01-\\x09\\x0B\\x0C\\x0E-\\x7F]))*\\])))>$/Di'), this.MessageID])) {
		this.lastMessageID = this.MessageID
	} else {
		this.lastMessageID = rt.call_function('sprintf', [rt.new_string('<%s@%s>'), this.uniqueid,
			rt.new_string(this.serverhostname())])
	}
	var_result = rt.concat(var_result, this.headerline(rt.new_string('Message-ID'),
		this.lastMessageID))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.Priority)))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('X-Priority'),
			this.Priority))
	}
	if rt.is_true(rt.identical(rt.new_string(''), this.XMailer)) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('X-Mailer'), rt.new_string(
			'PHPMailer ' +
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.version()).str() + ' (https://github.com/PHPMailer/PHPMailer)')))
	} else if this.XMailer.is_string()
		&& rt.is_true(rt.new_bool(this.XMailer.to_string().trim_space() != '')) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('X-Mailer'),
			rt.new_string(this.XMailer.to_string().trim_space())))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.ConfirmReadingTo)))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Disposition-Notification-To'), rt.new_string(
			'<' + (this.ConfirmReadingTo).str() + '>')))
	}
	mut iter_22 := this.CustomHeader.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_header := item_22.val
		var_result = rt.concat(var_result, this.headerline(rt.new_string((var_header.array_get(rt.new_int(0)).to_string().trim_space()).str()),
			rt.new_string(this.encodeheader(rt.new_string((var_header.array_get(rt.new_int(1)).to_string().trim_space()).str()), ''))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.sign_key_file)))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('MIME-Version'),
			rt.new_string('1.0')))
		var_result = rt.concat(var_result, this.getmailmime())
	}
	return var_result.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getmailmime() rt.PhpVal {
	mut var_result := rt.new_string('')
	mut var_ismultipart := rt.new_bool(true)
	mut switch_val_5 := this.message_type
	if rt.is_true(rt.equal(switch_val_5, rt.new_string('inline'))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_related()).str() + ';')))
		var_result = rt.concat(var_result, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(1))).str() + '"')))
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('attach')))
		|| rt.is_true(rt.equal(switch_val_5, rt.new_string('inline_attach')))
		|| rt.is_true(rt.equal(switch_val_5, rt.new_string('alt_attach')))
		|| rt.is_true(rt.equal(switch_val_5, rt.new_string('alt_inline_attach'))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_mixed()).str() + ';')))
		var_result = rt.concat(var_result, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(1))).str() + '"')))
	} else if rt.is_true(rt.equal(switch_val_5, rt.new_string('alt')))
		|| rt.is_true(rt.equal(switch_val_5, rt.new_string('alt_inline'))) {
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_alternative()).str() + ';')))
		var_result = rt.concat(var_result, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(1))).str() + '"')))
	} else {
		var_result = rt.concat(var_result, this.textline(rt.new_string('Content-Type: ' +
			(this.ContentType).str() + '; charset=' + (this.CharSet).str())))
		var_ismultipart = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_7bit(),
		this.Encoding))))
	{
		if rt.is_true(var_ismultipart) {
			if rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_8bit(),
				this.Encoding))
			{
				var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Transfer-Encoding'),
					Class_PHPMailer_PHPMailer_static.encoding_8bit()))
			}
		} else {
			var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Transfer-Encoding'),
				this.Encoding))
		}
	}
	return var_result.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsentmimemessage() string {
	return
		(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(rt.new_string((this.MIMEHeader).str() + this.mailHeader))).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() + (this.MIMEBody).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) generateid() rt.PhpVal {
	mut var_len := rt.new_int(32)
	mut var_bytes := rt.new_string('')
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('random_bytes')])) {
		var_bytes = rt.call_function('random_bytes', [var_len.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_5
			}
		}
		unsafe {
			goto end_label_5
		}
		catch_label_5:
		mut var_e_5 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_5, 'PHPMailer_PHPMailer_Exception') {
			mut var_e := var_e_5.clone()
			unsafe {
				goto end_label_5
			}
		} else {
			rt.throw_exception(var_e_5)
			unsafe {
				goto end_label_5
			}
		}

		end_label_5:
	} else if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('openssl_random_pseudo_bytes'),
	]))
	{
		var_bytes = rt.call_function('openssl_random_pseudo_bytes', [
			var_len.clone()])
	}
	if rt.is_true(rt.identical(var_bytes, rt.new_string(''))) {
		var_bytes = rt.call_function('hash', [rt.new_string('sha256'),
			rt.call_function('uniqid', [
				rt.new_string((rt.call_function('mt_rand', []rt.PhpVal{})).str()),
				rt.new_bool(true),
			]),
			rt.new_bool(true)])
	}
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '=' },
			rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '/' }]),
		rt.new_string(''),
		rt.call_function('base64_encode', [
			rt.call_function('hash', [rt.new_string('sha256'),
				var_bytes.clone(), rt.new_bool(true)]),
		]),
	])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) createbody() rt.PhpVal {
	mut var_body := rt.new_string('')
	this.setboundaries()
	this.setwordwrap()
	mut var_bodyEncoding := this.Encoding
	mut var_bodyCharSet := this.CharSet
	if this.UseSMTPUTF8 {
		var_bodyEncoding = Class_PHPMailer_PHPMailer_static.encoding_8bit()
	} else if
		rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_8bit(), var_bodyEncoding))
		&& !(this.has8bitchars(this.Body)) {
		var_bodyEncoding = Class_PHPMailer_PHPMailer_static.encoding_7bit()
		var_bodyCharSet = Class_PHPMailer_PHPMailer_static.charset_ascii()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_base64(), this.Encoding))))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(this.Body)) {
		var_bodyEncoding = Class_PHPMailer_PHPMailer_static.encoding_quoted_printable()
	}
	mut var_altBodyEncoding := this.Encoding
	mut var_altBodyCharSet := this.CharSet
	if rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_8bit(), var_altBodyEncoding))
		&& !(this.has8bitchars(this.AltBody)) {
		var_altBodyEncoding = Class_PHPMailer_PHPMailer_static.encoding_7bit()
		var_altBodyCharSet = Class_PHPMailer_PHPMailer_static.charset_ascii()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_base64(), var_altBodyEncoding))))
		&& rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(this.AltBody)) {
		var_altBodyEncoding = Class_PHPMailer_PHPMailer_static.encoding_quoted_printable()
	}
	if rt.is_true(this.sign_key_file) {
		this.Encoding = var_bodyEncoding.clone()
		var_body = rt.concat(var_body, rt.new_string((this.getmailmime()).str() +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()))
	}
	mut var_mimepre := rt.new_string('')
	mut switch_val_6 := this.message_type
	if rt.is_true(rt.equal(switch_val_6, rt.new_string('inline'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
			var_bodyCharSet.clone(), rt.new_string(''), var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('inline'),
			this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('attach'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
			var_bodyCharSet.clone(), rt.new_string(''), var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('attachment'),
			this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('inline_attach'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.textline(rt.new_string('--' +
			(this.boundary.array_get(rt.new_int(1))).str())))
		var_body = rt.concat(var_body, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_related()).str() + ';')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(2))).str() + '";')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' type="' +
			(Class_PHPMailer_PHPMailer_static.content_type_text_html()).str() + '"')))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
			var_bodyCharSet.clone(), rt.new_string(''), var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('inline'),
			this.boundary.array_get(rt.new_int(2))))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('attachment'),
			this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('alt'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
			var_altBodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_plaintext(),
			var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.AltBody, var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
			var_bodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_text_html(),
			var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		if !(!rt.is_true(this.Ical)) {
			mut var_method := Class_PHPMailer_PHPMailer_static.ical_method_request()
			mut iter_23 :=
				rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'IcalMethods').iterator()
			for {
				item_23 := iter_23.next() or { break }
				mut var_imethod := item_23.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
					this.Ical,
					rt.new_string('METHOD:' + var_imethod.str()),
				]), rt.new_bool(false)))))
				{
					var_method = var_imethod
				}
			}
			var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
				rt.new_string(''), rt.new_string(
				(Class_PHPMailer_PHPMailer_static.content_type_text_calendar()).str() +
				'; method=' + var_method.str()), rt.new_string('')))
			var_body = rt.concat(var_body, this.encodestring(this.Ical, this.Encoding))
			var_body = rt.concat(var_body,
				rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		}
		var_body = rt.concat(var_body, this.endboundary(this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('alt_inline'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(1)),
			var_altBodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_plaintext(),
			var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.AltBody, var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.textline(rt.new_string('--' +
			(this.boundary.array_get(rt.new_int(1))).str())))
		var_body = rt.concat(var_body, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_related()).str() + ';')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(2))).str() + '";')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' type="' +
			(Class_PHPMailer_PHPMailer_static.content_type_text_html()).str() + '"')))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
			var_bodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_text_html(),
			var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('inline'),
			this.boundary.array_get(rt.new_int(2))))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.endboundary(this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('alt_attach'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.textline(rt.new_string('--' +
			(this.boundary.array_get(rt.new_int(1))).str())))
		var_body = rt.concat(var_body, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_alternative()).str() + ';')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(2))).str() + '"')))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
			var_altBodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_plaintext(),
			var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.AltBody, var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
			var_bodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_text_html(),
			var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		if !(!rt.is_true(this.Ical)) {
			var_method = Class_PHPMailer_PHPMailer_static.ical_method_request()
			mut iter_24 :=
				rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'IcalMethods').iterator()
			for {
				item_24 := iter_24.next() or { break }
				mut var_imethod := item_24.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
					this.Ical,
					rt.new_string('METHOD:' + var_imethod.str()),
				]), rt.new_bool(false)))))
				{
					var_method = var_imethod
				}
			}
			var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
				rt.new_string(''), rt.new_string(
				(Class_PHPMailer_PHPMailer_static.content_type_text_calendar()).str() +
				'; method=' + var_method.str()), rt.new_string('')))
			var_body = rt.concat(var_body, this.encodestring(this.Ical, this.Encoding))
		}
		var_body = rt.concat(var_body, this.endboundary(this.boundary.array_get(rt.new_int(2))))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('attachment'),
			this.boundary.array_get(rt.new_int(1))))
	} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('alt_inline_attach'))) {
		var_body = rt.concat(var_body, var_mimepre)
		var_body = rt.concat(var_body, this.textline(rt.new_string('--' +
			(this.boundary.array_get(rt.new_int(1))).str())))
		var_body = rt.concat(var_body, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_alternative()).str() + ';')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(2))).str() + '"')))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(2)),
			var_altBodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_plaintext(),
			var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.AltBody, var_altBodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.textline(rt.new_string('--' +
			(this.boundary.array_get(rt.new_int(2))).str())))
		var_body = rt.concat(var_body, this.headerline(rt.new_string('Content-Type'), rt.new_string(
			(Class_PHPMailer_PHPMailer_static.content_type_multipart_related()).str() + ';')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' boundary="' +
			(this.boundary.array_get(rt.new_int(3))).str() + '";')))
		var_body = rt.concat(var_body, this.textline(rt.new_string(' type="' +
			(Class_PHPMailer_PHPMailer_static.content_type_text_html()).str() + '"')))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.getboundary(this.boundary.array_get(rt.new_int(3)),
			var_bodyCharSet.clone(), Class_PHPMailer_PHPMailer_static.content_type_text_html(),
			var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, this.encodestring(this.Body, var_bodyEncoding.clone()))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('inline'),
			this.boundary.array_get(rt.new_int(3))))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.endboundary(this.boundary.array_get(rt.new_int(2))))
		var_body = rt.concat(var_body, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		var_body = rt.concat(var_body, this.attachall(rt.new_string('attachment'),
			this.boundary.array_get(rt.new_int(1))))
	} else {
		this.Encoding = var_bodyEncoding.clone()
		var_body = rt.concat(var_body, this.encodestring(this.Body, this.Encoding))
	}
	if rt.is_true(this.iserror()) {
		var_body = rt.new_string('')
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('empty_message')),
				Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_critical())))
		}
	} else if rt.is_true(this.sign_key_file) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('PKCS7_TEXT'),
		])))))
		{
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('extension_missing'))).str() + 'openssl')))
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		mut var_file := rt.call_function('tempnam', [
			rt.call_function('sys_get_temp_dir', []rt.PhpVal{}),
			rt.new_string('srcsign'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		mut var_signed := rt.call_function('tempnam', [
			rt.call_function('sys_get_temp_dir', []rt.PhpVal{}),
			rt.new_string('mailsign'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		rt.call_function('file_put_contents', [var_file.clone(),
			var_body.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		if !rt.is_true(this.sign_extracerts_file) {
			mut var_sign := rt.call_function('openssl_pkcs7_sign', [
				var_file.clone(), var_signed.clone(),
				rt.new_string('file://' +
					(rt.call_function('realpath', [this.sign_cert_file])).str()),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'file://' +
						(rt.call_function('realpath', [this.sign_key_file])).str() },
					rt.ArrayItem{ key: none, val: this.sign_key_pass },
				]),
				rt.new_array()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		} else {
			var_sign = rt.call_function('openssl_pkcs7_sign', [
				var_file.clone(), var_signed.clone(),
				rt.new_string('file://' +
					(rt.call_function('realpath', [this.sign_cert_file])).str()),
				rt.create_array([
					rt.ArrayItem{ key: none, val: 'file://' +
						(rt.call_function('realpath', [this.sign_key_file])).str() },
					rt.ArrayItem{ key: none, val: this.sign_key_pass },
				]),
				rt.new_array(), rt.get_constant('PKCS7_DETACHED'), this.sign_extracerts_file])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		rt.call_function('unlink', [var_file.clone()])
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		if rt.is_true(var_sign) {
			var_body = rt.call_function('file_get_contents', [
				var_signed.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
			rt.call_function('unlink', [var_signed.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
			mut var_parts := rt.call_function('explode', [rt.new_string('\n\n'),
				var_body.clone(), rt.new_int(2)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
			this.MIMEHeader = rt.concat(this.MIMEHeader, rt.new_string(
				(var_parts.array_get(rt.new_int(0))).str() + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
				(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()))
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
			var_body = var_parts.array_get(rt.new_int(1))
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		} else {
			rt.call_function('unlink', [var_signed.clone()])
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('signing'))).str() +
				(rt.call_function('openssl_error_string', []rt.PhpVal{})).str())))
			if rt.has_exception() {
				unsafe {
					goto catch_label_6
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_6
			}
		}
		unsafe {
			goto end_label_6
		}
		catch_label_6:
		mut var_e_6 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_6, 'PHPMailer_PHPMailer_Exception') {
			mut var_exc := var_e_6.clone()
			var_body = rt.new_string('')
			if rt.is_true(this.exceptions) {
				rt.throw_exception(var_exc)
			}
			unsafe {
				goto end_label_6
			}
		} else {
			rt.throw_exception(var_e_6)
			unsafe {
				goto end_label_6
			}
		}

		end_label_6:
	}
	return var_body.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getboundaries() rt.PhpVal {
	if !rt.is_true(this.boundary) {
		this.setboundaries()
	}
	return this.boundary
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getboundary(var_boundary rt.PhpVal, var_charSet rt.PhpVal, var_contentType rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	mut var_charSet_mutated := var_charSet
	mut var_contentType_mutated := var_contentType
	mut var_encoding_mutated := var_encoding
	mut var_result := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_string(''), var_charSet_mutated)) {
		var_charSet_mutated = this.CharSet
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_contentType_mutated)) {
		var_contentType_mutated = this.ContentType
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_encoding_mutated)) {
		var_encoding_mutated = this.Encoding
	}
	var_result = rt.concat(var_result, this.textline(rt.new_string('--' + var_boundary.str())))
	var_result = rt.concat(var_result, rt.call_function('sprintf', [
		rt.new_string('Content-Type: %s; charset=%s'),
		var_contentType_mutated.clone(),
		var_charSet_mutated.clone(),
	]))
	var_result = rt.concat(var_result, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_7bit(),
		var_encoding_mutated))))
	{
		var_result = rt.concat(var_result, this.headerline(rt.new_string('Content-Transfer-Encoding'),
			var_encoding_mutated.clone()))
	}
	var_result = rt.concat(var_result, rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
	return var_result.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) endboundary(var_boundary rt.PhpVal) string {
	return (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() + '--' +
		var_boundary.str() + '--' +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setmessagetype() {
	mut var_type := rt.new_array()
	if this.alternativeexists() {
		var_type.array_push('alt')
	}
	if this.inlineimageexists() {
		var_type.array_push('inline')
	}
	if this.attachmentexists() {
		var_type.array_push('attach')
	}
	this.message_type = rt.call_function('implode', [rt.new_string('_'),
		var_type.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), this.message_type)) {
		this.message_type = rt.new_string('plain')
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) headerline(var_name rt.PhpVal, var_value rt.PhpVal) string {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	return var_name_mutated.str() + ': ' + var_value_mutated.str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) textline(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	return var_value_mutated.str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addattachment(var_path rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_path_mutated := var_path
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_path_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('file_access'))).str() +
			var_path_mutated.str(),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_continue())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(type_mutated))) {
		type_mutated =
			(Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(var_path_mutated.clone())).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	mut var_filename := rt.new_string((Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_path_mutated.clone(),
		rt.get_constant('PATHINFO_BASENAME'))).str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(name_mutated))) {
		name_mutated = var_filename.str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.validateencoding(var_encoding_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
			var_encoding_mutated.str())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_7
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	this.attachment.array_push(rt.create_array([
		rt.ArrayItem{ key: 0, val: var_path_mutated },
		rt.ArrayItem{ key: 1, val: var_filename },
		rt.ArrayItem{ key: 2, val: name_mutated },
		rt.ArrayItem{ key: 3, val: var_encoding_mutated },
		rt.ArrayItem{ key: 4, val: type_mutated },
		rt.ArrayItem{ key: 5, val: false },
		rt.ArrayItem{ key: 6, val: disposition_mutated },
		rt.ArrayItem{ key: 7, val: name_mutated },
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_7.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getattachments() rt.PhpVal {
	return this.attachment
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) attachall(var_disposition_type rt.PhpVal, var_boundary rt.PhpVal) string {
	mut var_mime := rt.new_array()
	mut var_cidUniq := rt.new_array()
	mut var_incl := rt.new_array()
	mut iter_25 := this.attachment.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_attachment := item_25.val
		if rt.is_true(rt.identical(var_attachment.array_get(rt.new_int(6)), var_disposition_type)) {
			mut var_string := rt.new_string('')
			mut var_path := rt.new_string('')
			mut var_bString := var_attachment.array_get(rt.new_int(5))
			if rt.is_true(var_bString) {
				var_string = var_attachment.array_get(rt.new_int(0))
			} else {
				var_path = var_attachment.array_get(rt.new_int(0))
			}
			mut var_inclhash := rt.call_function('hash', [rt.new_string('sha256'),
				rt.call_function('serialize', [var_attachment.clone()])])
			if rt.is_true(rt.call_function('in_array', [var_inclhash.clone(),
				var_incl.clone(), rt.new_bool(true)]))
			{
				continue
			}
			var_incl.array_push(var_inclhash.clone())
			mut var_name := var_attachment.array_get(rt.new_int(2))
			mut var_encoding := var_attachment.array_get(rt.new_int(3))
			mut var_type := var_attachment.array_get(rt.new_int(4))
			mut var_disposition := var_attachment.array_get(rt.new_int(6))
			mut var_cid := var_attachment.array_get(rt.new_int(7))
			if rt.is_true(rt.identical(rt.new_string('inline'), var_disposition))
				&& rt.is_true(rt.new_bool(var_cidUniq.clone().array_isset(var_cid.clone()))) {
				continue
			}
			var_cidUniq.array_set(var_cid, true)
			var_mime.array_push(rt.call_function('sprintf', [
				rt.new_string('--%s%s'), var_boundary.clone(),
				rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')]))
			if !(!rt.is_true(var_name)) {
				var_mime.array_push(rt.call_function('sprintf', [
					rt.new_string('Content-Type: %s; name=%s%s'),
					var_type.clone(),
					Class_PHPMailer_PHPMailer_PHPMailer.quotedstring(rt.new_string(this.encodeheader(rt.new_string(this.secureheader(var_name.clone())),
						''))),
					rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
				]))
			} else {
				var_mime.array_push(rt.call_function('sprintf', [
					rt.new_string('Content-Type: %s%s'),
					var_type.clone(),
					rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
				]))
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_7bit(),
				var_encoding))))
			{
				var_mime.array_push(rt.call_function('sprintf', [
					rt.new_string('Content-Transfer-Encoding: %s%s'),
					var_encoding.clone(),
					rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
				]))
			}
			if rt.is_true(rt.new_bool(var_cid.str() != ''))
				&& rt.is_true(rt.identical(var_disposition, rt.new_string('inline'))) {
				var_mime.array_push('Content-ID: <' +
					this.encodeheader(rt.new_string(this.secureheader(var_cid.clone())), '') + '>' +
					(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
			}
			if !(!rt.is_true(var_disposition)) {
				mut var_encoded_name :=
					rt.new_string(this.encodeheader(rt.new_string(this.secureheader(var_name.clone())), ''))
				if !(!rt.is_true(var_encoded_name)) {
					var_mime.array_push(rt.call_function('sprintf', [
						rt.new_string('Content-Disposition: %s; filename=%s%s'),
						var_disposition.clone(),
						Class_PHPMailer_PHPMailer_PHPMailer.quotedstring(var_encoded_name.clone()),
						rt.new_string(
							(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
							(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()),
					]))
				} else {
					var_mime.array_push(rt.call_function('sprintf', [
						rt.new_string('Content-Disposition: %s%s'),
						var_disposition.clone(),
						rt.new_string(
							(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
							(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()),
					]))
				}
			} else {
				var_mime.array_push(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
			}
			if rt.is_true(var_bString) {
				var_mime.array_push(this.encodestring(var_string.clone(), var_encoding.clone()))
			} else {
				var_mime.array_push(this.encodefile(var_path.clone(), var_encoding.clone()))
			}
			if rt.is_true(this.iserror()) {
				return ''
			}
			var_mime.array_push(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		}
	}
	var_mime.array_push(rt.call_function('sprintf', [rt.new_string('--%s--%s'),
		var_boundary.clone(), rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')]))
	return (rt.call_function('implode', [rt.new_string(''), var_mime.clone()])).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodefile(var_path rt.PhpVal, var_encoding rt.PhpVal) string {
	mut var_path_mutated := var_path
	mut var_encoding_mutated := var_encoding
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_path_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('file_open'))).str() +
			var_path_mutated.str(),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_continue())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	mut var_file_buffer := rt.call_function('file_get_contents', [
		var_path_mutated.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_file_buffer)) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('file_open'))).str() +
			var_path_mutated.str(),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_continue())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_8
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	var_file_buffer = this.encodestring(var_file_buffer.clone(), var_encoding_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	return var_file_buffer.str()
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_8.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return ''
		unsafe {
			goto end_label_8
		}
	} else {
		rt.throw_exception(var_e_8)
		unsafe {
			goto end_label_8
		}
	}

	end_label_8:
	return ''
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodestring(var_str rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
	mut var_encoding_mutated := var_encoding
	mut var_encoded := rt.new_string('')
	mut switch_val_7 := rt.new_string(var_encoding_mutated.clone().to_string().to_lower())
	if rt.is_true(rt.equal(switch_val_7, Class_PHPMailer_PHPMailer_static.encoding_base64())) {
		var_encoded = rt.call_function('chunk_split', [
			rt.call_function('base64_encode', [var_str_mutated.clone()]),
			Class_PHPMailer_PHPMailer_static.std_line_length(),
			rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
		])
	} else if rt.is_true(rt.equal(switch_val_7, Class_PHPMailer_PHPMailer_static.encoding_7bit()))
		|| rt.is_true(rt.equal(switch_val_7, Class_PHPMailer_PHPMailer_static.encoding_8bit())) {
		var_encoded = Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_str_mutated.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('substr', [
			var_encoded.clone(),
			rt.new_int(-rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE').to_string().len),
		]), rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')))))
		{
			var_encoded = rt.concat(var_encoded,
				rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'))
		}
	} else if rt.is_true(rt.equal(switch_val_7, Class_PHPMailer_PHPMailer_static.encoding_binary())) {
		var_encoded = var_str_mutated.clone()
	} else if rt.is_true(rt.equal(switch_val_7,
		Class_PHPMailer_PHPMailer_static.encoding_quoted_printable()))
	{
		var_encoded = this.encodeqp(var_str_mutated.clone())
	} else {
		this.seterror(rt.new_string(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
			var_encoding_mutated.str()))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
				var_encoding_mutated.str())))
		}
	}
	return var_encoded.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeheader(var_str rt.PhpVal, position string) string {
	mut var_matches := rt.new_null()
	mut var_str_mutated := var_str
	mut position_mutated := position
	position_mutated = position_mutated.to_lower()
	if this.UseSMTPUTF8
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.identical(rt.new_string('comment'), rt.new_string(position_mutated)))))) {
		return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_str_mutated.clone()).to_string().trim_space()
	}
	mut var_matchcount := rt.new_int(0)
	mut switch_val_8 := rt.new_string(position_mutated.to_lower())
	if rt.is_true(rt.equal(switch_val_8, rt.new_string('phrase'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/[\\200-\\377]/'),
			var_str_mutated.clone(),
		])))))
		{
			mut var_encoded := rt.call_function('addcslashes', [
				var_str_mutated.clone(), rt.new_string('')])
			if rt.is_true(rt.identical(var_str_mutated, var_encoded))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string("/[^A-Za-z0-9!#$%&'*+\\/=?^_`{|}~ -]/"), var_str_mutated.clone()]))))) {
				return var_encoded.str()
			}
			return "\"${var_encoded.to_string()}\""
		}
		var_matchcount = rt.call_function('preg_match_all', [
			rt.new_string('/[^\\040\\041\\043-\\133\\135-\\176]/'),
			var_str_mutated.clone(),
			var_matches.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_8, rt.new_string('comment'))) {
		var_matchcount = rt.call_function('preg_match_all', [
			rt.new_string('/[()"]/'), var_str_mutated.clone(),
			var_matches.clone()])
	} else {
		var_matchcount = rt.add(var_matchcount, rt.call_function('preg_match_all', [
			rt.new_string('/[\\000-\\010\\013\\014\\016-\\037\\177-\\377]/'),
			var_str_mutated.clone(),
			var_matches.clone(),
		]))
	}
	if this.has8bitchars(var_str_mutated.clone()) {
		mut var_charset := this.CharSet
	} else {
		var_charset = Class_PHPMailer_PHPMailer_static.charset_ascii()
	}
	mut var_overhead := rt.new_int(8 + var_charset.clone().to_string().len)
	if rt.is_true(rt.identical(rt.new_string('mail'), this.Mailer)) {
		mut var_maxlen := rt.sub(Class_PHPMailer_PHPMailer_static.mail_max_line_length(),
			var_overhead)
	} else {
		var_maxlen = rt.sub(Class_PHPMailer_PHPMailer_static.max_line_length(), var_overhead)
	}
	if rt.is_true(rt.greater(var_matchcount, var_str_mutated.clone().to_string().len / 3)) {
		mut var_encoding := rt.new_string('B')
	} else if rt.is_true(rt.greater(var_matchcount, rt.new_int(0))) {
		var_encoding = rt.new_string('Q')
	} else if rt.is_true(rt.greater(rt.new_int(var_str_mutated.clone().to_string().len), var_maxlen)) {
		var_encoding = rt.new_string('Q')
	} else {
		var_encoding = rt.new_bool(false)
	}
	mut switch_val_9 := var_encoding
	if rt.is_true(rt.equal(switch_val_9, rt.new_string('B'))) {
		if this.hasmultibytes(var_str_mutated.clone()) {
			var_encoded = this.base64encodewrapmb(var_str_mutated.clone(), rt.new_string('\n'))
		} else {
			var_encoded = rt.call_function('base64_encode', [
				var_str_mutated.clone()])
			var_maxlen = rt.sub(var_maxlen, rt.mod_(var_maxlen, rt.new_int(4)))
			var_encoded = rt.new_string(rt.call_function('chunk_split', [
				var_encoded.clone(), var_maxlen.clone(), rt.new_string('\n')]).to_string().trim_space())
		}
		var_encoded = rt.call_function('preg_replace', [rt.new_string('/^(.*)$/m'),
			rt.new_string(' =?' + var_charset.str() + '?${var_encoding.to_string()}?\\1?='),
			var_encoded.clone()])
	} else if rt.is_true(rt.equal(switch_val_9, rt.new_string('Q'))) {
		var_encoded = this.encodeq(var_str_mutated.clone(), position_mutated)
		var_encoded = this.wraptext(var_encoded.clone(), var_maxlen.clone(), true)
		var_encoded = rt.call_function('str_replace', [
			rt.new_string('=' + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()),
			rt.new_string('\n'),
			rt.new_string(var_encoded.clone().to_string().trim_space()),
		])
		var_encoded = rt.call_function('preg_replace', [rt.new_string('/^(.*)$/m'),
			rt.new_string(' =?' + var_charset.str() + '?${var_encoding.to_string()}?\\1?='),
			var_encoded.clone()])
	} else {
		return var_str_mutated.str()
	}
	return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_encoded.clone()).to_string().trim_space()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(var_value rt.PhpVal, var_charset rt.PhpVal) string {
	mut var_value_mutated := var_value
	mut var_charset_mutated := var_charset
	if !(var_value_mutated.clone().is_string())
		|| rt.is_true(rt.identical(var_value_mutated, rt.new_string(''))) {
		return ''
	}
	mut var_hasEncodedWord := rt.new_bool((rt.call_function('preg_match', [
		rt.new_string('/=\\?.*\\?=/s'),
		var_value_mutated.clone(),
	])).to_bool())
	if rt.is_true(var_hasEncodedWord)
		&& rt.is_true(rt.call_function('defined', [rt.new_string('MB_CASE_UPPER')])) {
		mut var_origCharset := rt.call_function('mb_internal_encoding', []rt.PhpVal{})
		rt.call_function('mb_internal_encoding', [var_charset_mutated.clone()])
		if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80300))) {
			var_value_mutated = rt.call_function('str_replace', [
				rt.new_string('_'), rt.new_string('=20'), var_value_mutated.clone()])
		} else {
			var_value_mutated = rt.call_function('preg_replace', [
				rt.new_string('/(\\?=)\\s+(=\\?)/'),
				rt.new_string('$1$2'),
				var_value_mutated.clone(),
			])
		}
		var_value_mutated = rt.call_function('mb_decode_mimeheader', [
			var_value_mutated.clone()])
		rt.call_function('mb_internal_encoding', [var_origCharset.clone()])
	}
	return var_value_mutated.str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) hasmultibytes(var_str rt.PhpVal) bool {
	mut var_str_mutated := var_str
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strlen')])) {
		return (rt.greater(rt.new_int(var_str_mutated.clone().to_string().len), rt.call_function('mb_strlen', [
			var_str_mutated.clone(),
			this.CharSet,
		]))).to_bool()
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) has8bitchars(var_text rt.PhpVal) bool {
	mut var_text_mutated := var_text
	return (rt.call_function('preg_match', [rt.new_string('/[\\x80-\\xFF]/'),
		var_text_mutated.clone()])).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) base64encodewrapmb(var_str rt.PhpVal, var_linebreak rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
	mut var_linebreak_mutated := var_linebreak
	mut var_start := rt.new_string('=?' + (this.CharSet).str() + '?B?')
	mut var_end := rt.new_string('?=')
	mut var_encoded := rt.new_string('')
	if rt.is_true(rt.identical(rt.new_null(), var_linebreak_mutated)) {
		var_linebreak_mutated = rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')
	}
	mut var_mb_length := rt.call_function('mb_strlen', [var_str_mutated.clone(), this.CharSet])
	mut var_length := rt.new_int(75 - var_start.clone().to_string().len -
		var_end.clone().to_string().len)
	mut var_ratio := rt.div(var_mb_length, rt.new_int(var_str_mutated.clone().to_string().len))
	mut var_avgLength := rt.call_function('floor', [
		rt.new_float(var_length * var_ratio * 0.75),
	])
	mut var_offset := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_mb_length))) { break
		 }
		mut var_lookBack := rt.new_int(0)
		for {
			var_offset = rt.sub(var_avgLength, var_lookBack)
			mut var_chunk := rt.call_function('mb_substr', [var_str_mutated.clone(),
				var_i.clone(), var_offset.clone(), this.CharSet])
			var_chunk = rt.call_function('base64_encode', [var_chunk.clone()])
			rt.pre_inc(var_lookBack)
			if !(rt.is_true(rt.greater(rt.new_int(var_chunk.clone().to_string().len), var_length))) {
				break
			}
		}
		var_encoded = rt.concat(var_encoded, rt.new_string(var_chunk.str() +
			var_linebreak_mutated.str()))
		var_i = rt.add(var_i, var_offset)
	}
	return rt.call_function('substr', [var_encoded.clone(), rt.new_int(0),
		rt.new_int(-var_linebreak_mutated.clone().to_string().len)])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeqp(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
	return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(rt.call_function('quoted_printable_encode', [
		var_string_mutated.clone(),
	]))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeq(var_str rt.PhpVal, position string) rt.PhpVal {
	mut var_str_mutated := var_str
	mut position_mutated := position
	mut var_pattern := rt.new_string('')
	mut var_encoded := rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '\r' },
			rt.ArrayItem{ key: none, val: '\n' }]),
		rt.new_string(''),
		var_str_mutated.clone(),
	])
	mut switch_val_10 := rt.new_string(position_mutated.to_lower())
	if rt.is_true(rt.equal(switch_val_10, rt.new_string('phrase'))) {
		var_pattern = rt.new_string('^A-Za-z0-9!*+\\/ -')
	} else if rt.is_true(rt.equal(switch_val_10, rt.new_string('comment'))) {
		var_pattern = rt.new_string('\\(\\)"')
	} else {
		var_pattern = rt.new_string('\\000-\\011\\013\\014\\016-\\037\\075\\077\\137\\177-\\377' +
			var_pattern.str())
	}
	mut var_matches := rt.new_array()
	if rt.is_true(rt.call_function('preg_match_all', [
		rt.new_string('/[${var_pattern.to_string()}]/'),
		var_encoded.clone(),
		var_matches.clone(),
	]))
	{
		mut var_eqkey := rt.call_function('array_search', [rt.new_string('='),
			var_matches.array_get(rt.new_int(0)), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_eqkey)))) {
			var_matches.array_get(rt.new_int(0)).array_unset(var_eqkey)
			rt.call_function('array_unshift', [var_matches.array_get(rt.new_int(0)),
				rt.new_string('=')])
		}
		mut iter_26 :=
			rt.call_function('array_unique', [var_matches.array_get(rt.new_int(0))]).iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_char := item_26.val
			var_encoded = rt.call_function('str_replace', [var_char.clone(),
				rt.new_string('=' +(rt.call_function('sprintf', [rt.new_string('%02X'), rt.call_function('ord', [var_char.clone()])])).str()),
				var_encoded.clone()])
		}
	}
	return rt.call_function('str_replace', [rt.new_string(' '),
		rt.new_string('_'), var_encoded.clone()])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addstringattachment(var_string rt.PhpVal, var_filename rt.PhpVal, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_string_mutated := var_string
	mut var_filename_mutated := var_filename
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(type_mutated))) {
		type_mutated =
			(Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(var_filename_mutated.clone())).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_9
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.validateencoding(var_encoding_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
			var_encoding_mutated.str())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_9
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	this.attachment.array_push(rt.create_array([
		rt.ArrayItem{ key: 0, val: var_string_mutated },
		rt.ArrayItem{ key: 1, val: var_filename_mutated },
		rt.ArrayItem{ key: 2, val: Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_filename_mutated.clone(),
			rt.get_constant('PATHINFO_BASENAME')) },
		rt.ArrayItem{ key: 3, val: var_encoding_mutated },
		rt.ArrayItem{ key: 4, val: type_mutated },
		rt.ArrayItem{ key: 5, val: true },
		rt.ArrayItem{ key: 6, val: disposition_mutated },
		rt.ArrayItem{ key: 7, val: 0 },
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_9
		}
	}
	unsafe {
		goto end_label_9
	}
	catch_label_9:
	mut var_e_9 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_9, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_9.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
		unsafe {
			goto end_label_9
		}
	} else {
		rt.throw_exception(var_e_9)
		unsafe {
			goto end_label_9
		}
	}

	end_label_9:
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addembeddedimage(var_path rt.PhpVal, var_cid rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_path_mutated := var_path
	mut var_cid_mutated := var_cid
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_path_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('file_access'))).str() +
			var_path_mutated.str(),
			Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.stop_continue())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(type_mutated))) {
		type_mutated =
			(Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(var_path_mutated.clone())).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.validateencoding(var_encoding_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
			var_encoding_mutated.str())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	mut var_filename := rt.new_string((Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_path_mutated.clone(),
		rt.get_constant('PATHINFO_BASENAME'))).str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(name_mutated))) {
		name_mutated = var_filename.str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_10
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	this.attachment.array_push(rt.create_array([
		rt.ArrayItem{ key: 0, val: var_path_mutated },
		rt.ArrayItem{ key: 1, val: var_filename },
		rt.ArrayItem{ key: 2, val: name_mutated },
		rt.ArrayItem{ key: 3, val: var_encoding_mutated },
		rt.ArrayItem{ key: 4, val: type_mutated },
		rt.ArrayItem{ key: 5, val: false },
		rt.ArrayItem{ key: 6, val: disposition_mutated },
		rt.ArrayItem{ key: 7, val: var_cid_mutated },
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_10
		}
	}
	unsafe {
		goto end_label_10
	}
	catch_label_10:
	mut var_e_10 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_10, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_10.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
		unsafe {
			goto end_label_10
		}
	} else {
		rt.throw_exception(var_e_10)
		unsafe {
			goto end_label_10
		}
	}

	end_label_10:
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addstringembeddedimage(var_string rt.PhpVal, var_cid rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_string_mutated := var_string
	mut var_cid_mutated := var_cid
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(type_mutated)))
		&& !(name_mutated == '') {
		type_mutated =
			(Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(rt.new_string(name_mutated))).str()
		if rt.has_exception() {
			unsafe {
				goto catch_label_11
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.validateencoding(var_encoding_mutated.clone()))))) {
		rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
			(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('encoding'))).str() +
			var_encoding_mutated.str())))
		if rt.has_exception() {
			unsafe {
				goto catch_label_11
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	this.attachment.array_push(rt.create_array([
		rt.ArrayItem{ key: 0, val: var_string_mutated },
		rt.ArrayItem{ key: 1, val: name_mutated },
		rt.ArrayItem{ key: 2, val: name_mutated },
		rt.ArrayItem{ key: 3, val: var_encoding_mutated },
		rt.ArrayItem{ key: 4, val: type_mutated },
		rt.ArrayItem{ key: 5, val: true },
		rt.ArrayItem{ key: 6, val: disposition_mutated },
		rt.ArrayItem{ key: 7, val: var_cid_mutated },
	]))
	if rt.has_exception() {
		unsafe {
			goto catch_label_11
		}
	}
	unsafe {
		goto end_label_11
	}
	catch_label_11:
	mut var_e_11 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_11, 'PHPMailer_PHPMailer_Exception') {
		mut var_exc := var_e_11.clone()
		this.seterror(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		this.edebug(rt.call_method(var_exc, 'getMessage', []rt.PhpVal{}))
		if rt.is_true(this.exceptions) {
			rt.throw_exception(var_exc)
		}
		return false
		unsafe {
			goto end_label_11
		}
	} else {
		rt.throw_exception(var_e_11)
		unsafe {
			goto end_label_11
		}
	}

	end_label_11:
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) validateencoding(var_encoding rt.PhpVal) rt.PhpVal {
	mut var_encoding_mutated := var_encoding
	return rt.call_function('in_array', [var_encoding_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.encoding_7bit()
			},
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.encoding_quoted_printable()
			},
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.encoding_base64()
			},
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.encoding_8bit()
			},
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.encoding_binary()
			},
		]),
		rt.new_bool(true)])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) cidexists(var_cid rt.PhpVal) bool {
	mut var_cid_mutated := var_cid
	mut iter_27 := this.attachment.iterator()
	for {
		item_27 := iter_27.next() or { break }
		mut var_attachment := item_27.val
		if rt.is_true(rt.identical(rt.new_string('inline'), var_attachment.array_get(rt.new_int(6))))
			&& rt.is_true(rt.identical(var_cid_mutated, var_attachment.array_get(rt.new_int(7)))) {
			return true
		}
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) inlineimageexists() bool {
	mut iter_28 := this.attachment.iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_attachment := item_28.val
		if rt.is_true(rt.identical(rt.new_string('inline'), var_attachment.array_get(rt.new_int(6)))) {
			return true
		}
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) attachmentexists() bool {
	mut iter_29 := this.attachment.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_attachment := item_29.val
		if rt.is_true(rt.identical(rt.new_string('attachment'),
			var_attachment.array_get(rt.new_int(6))))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) alternativeexists() bool {
	return !(!rt.is_true(this.AltBody))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearqueuedaddresses(var_kind rt.PhpVal) {
	closure_1_fn := fn [var_kind] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_params := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	this.RecipientsQueue = rt.call_function('array_filter', [this.RecipientsQueue,
		rt.new_closure(closure_1_fn)])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearaddresses() {
	mut iter_30 := this.to.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_to := item_30.val
		this.all_recipients.array_unset(rt.new_string(var_to.array_get(rt.new_int(0)).to_string().to_lower()))
	}
	this.to = rt.new_array()
	this.clearqueuedaddresses(rt.new_string('to'))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearccs() {
	mut iter_31 := this.cc.iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_cc := item_31.val
		this.all_recipients.array_unset(rt.new_string(var_cc.array_get(rt.new_int(0)).to_string().to_lower()))
	}
	this.cc = rt.new_array()
	this.clearqueuedaddresses(rt.new_string('cc'))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearbccs() {
	mut iter_32 := this.bcc.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_bcc := item_32.val
		this.all_recipients.array_unset(rt.new_string(var_bcc.array_get(rt.new_int(0)).to_string().to_lower()))
	}
	this.bcc = rt.new_array()
	this.clearqueuedaddresses(rt.new_string('bcc'))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearreplytos() {
	this.ReplyTo = rt.new_array()
	this.ReplyToQueue = rt.new_array()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearallrecipients() {
	this.to = rt.new_array()
	this.cc = rt.new_array()
	this.bcc = rt.new_array()
	this.all_recipients = rt.new_array()
	this.RecipientsQueue = rt.new_array()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearattachments() {
	this.attachment = rt.new_array()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearcustomheaders() {
	this.CustomHeader = rt.new_array()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearcustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_null(), var_value_mutated))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_name_mutated.clone(), rt.new_string(':')]), rt.new_bool(false))))) {
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string(':'),
			var_name_mutated.clone(), rt.new_int(2)])
		var_name_mutated = list_tmp_1.array_get(0)
		var_value_mutated = list_tmp_1.array_get(1)
	}
	var_name_mutated = rt.new_string(var_name_mutated.clone().to_string().trim_space())
	var_value_mutated = if rt.is_true(rt.identical(rt.new_null(), var_value_mutated)) {
		rt.new_null()
	} else {
		rt.new_string(var_value_mutated.clone().to_string().trim_space())
	}
	mut iter_33 := this.CustomHeader.iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_pair := item_33.val
		mut var_k := item_33.key
		if rt.is_true(rt.equal(var_pair.array_get(rt.new_int(0)), var_name_mutated)) {
			if rt.is_true(rt.identical(rt.new_null(), var_value_mutated))
				|| rt.is_true(rt.equal(var_pair.array_get(rt.new_int(1)), var_value_mutated)) {
				this.CustomHeader.array_unset(var_k)
			}
		}
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) replacecustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_null(), var_value_mutated))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_name_mutated.clone(), rt.new_string(':')]), rt.new_bool(false))))) {
		mut list_tmp_2 := rt.call_function('explode', [rt.new_string(':'),
			var_name_mutated.clone(), rt.new_int(2)])
		var_name_mutated = list_tmp_2.array_get(0)
		var_value_mutated = list_tmp_2.array_get(1)
	}
	var_name_mutated = rt.new_string(var_name_mutated.clone().to_string().trim_space())
	var_value_mutated = rt.new_string((if rt.is_true(rt.identical(rt.new_null(), var_value_mutated)) {
		''
	} else {
		var_value_mutated.clone().to_string().trim_space()
	}).str())
	mut var_replaced := rt.new_bool(false)
	mut iter_34 := this.CustomHeader.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_pair := item_34.val
		mut var_k := item_34.key
		if rt.is_true(rt.equal(var_pair.array_get(rt.new_int(0)), var_name_mutated)) {
			if rt.is_true(var_replaced) {
				this.CustomHeader.array_unset(var_k)
				continue
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpbrk', [
				rt.new_string(var_name_mutated.str() + var_value_mutated.str()),
				rt.new_string('\r\n'),
			]), rt.new_bool(false)))))
			{
				if rt.is_true(this.exceptions) {
					rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
						create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_header')))))
				}
				return false
			}
			this.CustomHeader.array_set(var_k, rt.create_array([
				rt.ArrayItem{ key: none, val: var_name_mutated },
				rt.ArrayItem{ key: none, val: var_value_mutated },
			]))
			var_replaced = rt.new_bool(true)
		}
	}
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) seterror(var_msg rt.PhpVal) {
	rt.pre_inc(this.error_count)
	if rt.is_true(rt.identical(rt.new_string('smtp'), this.Mailer))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.smtp)))) {
		mut var_lasterror := rt.call_method(this.smtp, 'getError', []rt.PhpVal{})
		if !(!rt.is_true(var_lasterror.array_get(rt.new_string('error')))) {
			var_msg = rt.concat(var_msg, rt.new_string(' ' +
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('smtp_error'))).str() +
				(var_lasterror.array_get(rt.new_string('error'))).str()))
			if !(!rt.is_true(var_lasterror.array_get(rt.new_string('detail')))) {
				var_msg = rt.concat(var_msg, rt.new_string(' ' +
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('smtp_detail'))).str() +
					(var_lasterror.array_get(rt.new_string('detail'))).str()))
			}
			if !(!rt.is_true(var_lasterror.array_get(rt.new_string('smtp_code')))) {
				var_msg = rt.concat(var_msg, rt.new_string(' ' +
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('smtp_code'))).str() +
					(var_lasterror.array_get(rt.new_string('smtp_code'))).str()))
			}
			if !(!rt.is_true(var_lasterror.array_get(rt.new_string('smtp_code_ex')))) {
				var_msg = rt.concat(var_msg, rt.new_string(' ' +
					(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('smtp_code_ex'))).str() +
					(var_lasterror.array_get(rt.new_string('smtp_code_ex'))).str()))
			}
		}
	}
	this.ErrorInfo = var_msg.clone()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.rfcdate() rt.PhpVal {
	rt.call_function('date_default_timezone_set', [
		rt.call_function('date_default_timezone_get', []rt.PhpVal{}),
	])
	return rt.call_function('date', [rt.new_string('D, j M Y H:i:s O')])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) serverhostname() string {
	mut var_result := rt.new_string('')
	if !(!rt.is_true(this.Hostname)) {
		var_result = this.Hostname
	} else if !(rt.get_superglobal('_SERVER')).is_null()
		&& rt.is_true(rt.new_bool(rt.get_superglobal('_SERVER').clone().array_isset(rt.new_string('SERVER_NAME')))) {
		var_result = rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_NAME'))
	} else if rt.is_true(rt.call_function('function_exists', [rt.new_string('gethostname')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('gethostname', []rt.PhpVal{}), rt.new_bool(false))))) {
		var_result = rt.call_function('gethostname', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('php_uname', [
		rt.new_string('n'),
	]), rt.new_string('')))))
	{
		var_result = rt.call_function('php_uname', [rt.new_string('n')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.isvalidhost(var_result.clone()))))) {
		return 'localhost.localdomain'
	}
	return var_result.str()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.isvalidhost(var_host rt.PhpVal) bool {
	mut var_host_mutated := var_host
	if !rt.is_true(var_host_mutated) || !(var_host_mutated.clone().is_string())
		|| var_host_mutated.clone().to_string().len > 256
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^([a-z\\d.-]*|\\[[a-f\\d:]+\\])$/i'), var_host_mutated.clone()]))))) {
		return false
	}
	if var_host_mutated.clone().to_string().len > 2
		&& rt.is_true(rt.identical(rt.call_function('substr', [var_host_mutated.clone(), rt.new_int(0), rt.new_int(1)]), rt.new_string('[')))
		&& rt.is_true(rt.identical(rt.call_function('substr', [var_host_mutated.clone(), rt.new_int(-1), rt.new_int(1)]), rt.new_string(']'))) {
		return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('filter_var', [
			rt.call_function('substr', [var_host_mutated.clone(),
				rt.new_int(1), rt.new_int(-1)]),
			rt.get_constant('FILTER_VALIDATE_IP'),
			rt.get_constant('FILTER_FLAG_IPV6'),
		]), rt.new_bool(false))))
	}
	if rt.is_true(rt.new_bool(
		rt.call_function('str_replace', [rt.new_string('.'), rt.new_string(''), var_host_mutated.clone()]).is_long()
		|| rt.call_function('str_replace', [rt.new_string('.'), rt.new_string(''), var_host_mutated.clone()]).is_double()))
	{
		return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('filter_var', [
			var_host_mutated.clone(),
			rt.get_constant('FILTER_VALIDATE_IP'),
			rt.get_constant('FILTER_FLAG_IPV4'),
		]), rt.new_bool(false))))
	}
	return rt.new_bool(!rt.is_true(rt.identical(rt.call_function('filter_var', [
		rt.new_string('https://' + var_host_mutated.str()),
		rt.get_constant('FILTER_VALIDATE_URL'),
	]), rt.new_bool(false))))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addresshasunicodelocalpart(var_address rt.PhpVal) bool {
	mut var_address_mutated := var_address
	return (rt.call_function('preg_match', [rt.new_string('/[\\x80-\\xFF].*@/'),
		var_address_mutated.clone()])).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) anyaddresshasunicodelocalpart(var_addresses rt.PhpVal) bool {
	mut var_addresses_mutated := var_addresses
	mut iter_35 := var_addresses_mutated.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_address := item_35.val
		if rt.is_true(rt.new_bool(var_address.clone().is_array())) {
			var_address = var_address.array_get(rt.new_int(0))
		}
		if this.addresshasunicodelocalpart(var_address.clone()) {
			return true
		}
	}
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) needssmtputf8() bool {
	return this.UseSMTPUTF8
}

fn Class_PHPMailer_PHPMailer_PHPMailer.lang(var_key rt.PhpVal) string {
	if rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language').array_count() < 1 {
		Class_PHPMailer_PHPMailer_PHPMailer.setlanguage()
	}
	if rt.is_true(rt.new_bool(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language').array_isset(var_key.clone()))) {
		if rt.is_true(rt.identical(rt.new_string('smtp_connect_failed'), var_key)) {
			return
				(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language').array_get(var_key)).str() +
				' https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting'
		}
		return (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'language').array_get(var_key)).str()
	}
	return var_key.str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtperrormessage(var_base_key rt.PhpVal) rt.PhpVal {
	mut var_message := Class_PHPMailer_PHPMailer_PHPMailer.lang(var_base_key.clone())
	mut var_error := rt.call_method(this.smtp, 'getError', []rt.PhpVal{})
	if !(!rt.is_true(var_error.array_get(rt.new_string('error')))) {
		var_message = rt.concat(var_message, rt.new_string(' ' +
			(var_error.array_get(rt.new_string('error'))).str()))
		if !(!rt.is_true(var_error.array_get(rt.new_string('detail')))) {
			var_message = rt.concat(var_message, rt.new_string(' ' +
				(var_error.array_get(rt.new_string('detail'))).str()))
		}
	}
	return var_message.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) iserror() rt.PhpVal {
	return rt.new_bool(this.error_count > 0)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addcustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_null(), var_value_mutated))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_name_mutated.clone(), rt.new_string(':')]), rt.new_bool(false))))) {
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string(':'),
			var_name_mutated.clone(), rt.new_int(2)])
		var_name_mutated = list_tmp_3.array_get(0)
		var_value_mutated = list_tmp_3.array_get(1)
	}
	var_name_mutated = rt.new_string(var_name_mutated.clone().to_string().trim_space())
	var_value_mutated = rt.new_string((if rt.is_true(rt.identical(rt.new_null(), var_value_mutated)) {
		''
	} else {
		var_value_mutated.clone().to_string().trim_space()
	}).str())
	if !rt.is_true(var_name_mutated)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpbrk', [rt.new_string(var_name_mutated.str() + var_value_mutated.str()), rt.new_string('\r\n')]), rt.new_bool(false))))) {
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{},
				create_phpmailer_phpmailer_exception(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_header')))))
		}
		return false
	}
	this.CustomHeader.array_push(rt.create_array([
		rt.ArrayItem{ key: none, val: var_name_mutated },
		rt.ArrayItem{ key: none, val: var_value_mutated },
	]))
	return true
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getcustomheaders() rt.PhpVal {
	return this.CustomHeader
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) msghtml(var_message rt.PhpVal, basedir string, advanced bool) rt.PhpVal {
	mut var_images := rt.new_null()
	mut var_message_mutated := var_message
	mut var_cid_domain := rt.new_string('phpmailer.0')
	if rt.is_true(rt.call_function('filter_var',
		[this.From, rt.get_constant('FILTER_VALIDATE_EMAIL')]))
	{
		var_cid_domain = rt.call_function('substr', [this.From,
			rt.add(rt.call_function('strrpos', [this.From, rt.new_string('@')]), rt.new_int(1))])
	}
	rt.call_function('preg_match_all', [
		rt.new_string('/(?<!-)(src|background)=["\'](.*)["\']/Ui'),
		var_message_mutated.clone(),
		var_images.clone(),
	])
	if rt.is_true(rt.new_bool(var_images.clone().array_isset(rt.new_int(2)))) {
		if basedir.len > 1
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), rt.call_function('substr', [rt.new_string(basedir), rt.new_int(-1)]))))) {
			basedir = basedir + '/'
		}
		mut iter_36 := var_images.array_get(rt.new_int(2)).iterator()
		for {
			item_36 := iter_36.next() or { break }
			mut var_url := item_36.val
			mut var_imgindex := item_36.key
			mut var_match := rt.new_array()
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('#^data:(image/(?:jpe?g|gif|png));?(base64)?,(.+)#'),
				var_url.clone(),
				var_match.clone(),
			]))
			{
				if var_match.clone().array_count() == 4
					&& rt.is_true(rt.identical(Class_PHPMailer_PHPMailer_static.encoding_base64(), var_match.array_get(rt.new_int(2)))) {
					mut var_data := rt.call_function('base64_decode', [
						var_match.array_get(rt.new_int(3)),
					])
				} else if rt.is_true(rt.identical(rt.new_string(''),
					var_match.array_get(rt.new_int(2))))
				{
					var_data = rt.call_function('rawurldecode', [
						var_match.array_get(rt.new_int(3)),
					])
				} else {
					continue
				}
				mut var_cid := rt.new_string(
					(rt.call_function('substr', [rt.call_function('hash', [rt.new_string('sha256'), var_data.clone()]), rt.new_int(0), rt.new_int(32)])).str() +
					'@' + var_cid_domain.str())
				if !(this.cidexists(var_cid.clone())) {
					this.addstringembeddedimage(var_data.clone(), var_cid.clone(), 'embed' +
						var_imgindex.str(), Class_PHPMailer_PHPMailer_static.encoding_base64(),
						(var_match.array_get(rt.new_int(1))).str(), '')
				}
				var_message_mutated = rt.call_function('str_replace', [
					var_images.array_get(rt.new_int(0)).array_get(var_imgindex),
					rt.new_string(
						(var_images.array_get(rt.new_int(1)).array_get(var_imgindex)).str() + '="cid:' + var_cid.str() +
						'"'),
					var_message_mutated.clone(),
				])
				continue
			}
			if !(basedir == '')
				&& rt.is_true(rt.identical(rt.call_function('strpos', [var_url.clone(), rt.new_string('..')]), rt.new_bool(false)))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [var_url.clone(), rt.new_string('cid:')])))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^[a-z][a-z0-9+.-]*:?//#i'), var_url.clone()]))))) {
				mut var_filename := Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_url.clone(),
					rt.get_constant('PATHINFO_BASENAME'))
				mut var_directory := rt.call_function('dirname', [
					var_url.clone()])
				if rt.is_true(rt.identical(rt.new_string('.'), var_directory)) {
					var_directory = rt.new_string('')
				}
				var_cid = rt.new_string(
					(rt.call_function('substr', [rt.call_function('hash', [rt.new_string('sha256'), var_url.clone()]), rt.new_int(0), rt.new_int(32)])).str() +
					'@' + var_cid_domain.str())
				if basedir.len > 1
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), rt.call_function('substr', [rt.new_string(basedir), rt.new_int(-1)]))))) {
					basedir = basedir + '/'
				}
				if var_directory.clone().to_string().len > 1
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), rt.call_function('substr', [var_directory.clone(), rt.new_int(-1)]))))) {
					var_directory = rt.concat(var_directory, rt.new_string('/'))
				}
				if this.addembeddedimage(rt.new_string(basedir + var_directory.str() +
					var_filename.str()), var_cid.clone(), var_filename.str(),
					Class_PHPMailer_PHPMailer_static.encoding_base64(), (Class_PHPMailer_PHPMailer_PHPMailer._mime_types((Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_filename.clone(),
					rt.get_constant('PATHINFO_EXTENSION'))).str())).str(), '')
				{
					var_message_mutated = rt.call_function('preg_replace', [
						rt.new_string('/' +
							(var_images.array_get(rt.new_int(1)).array_get(var_imgindex)).str() + '=["\']' + (rt.call_function('preg_quote', [var_url.clone(), rt.new_string('/')])).str() +
							'["\']/Ui'),
						rt.new_string(
							(var_images.array_get(rt.new_int(1)).array_get(var_imgindex)).str() + '="cid:' + var_cid.str() +
							'"'),
						var_message_mutated.clone(),
					])
				}
			}
		}
	}
	this.ishtml(false)
	this.Body = Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_message_mutated.clone())
	this.AltBody = Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(this.html2text(var_message_mutated.clone(),
		advanced))
	if !(this.alternativeexists()) {
		this.AltBody =
			'This is an HTML-only message. To view it, activate HTML in your email application.' +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()
	}
	return this.Body
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) html2text(var_html rt.PhpVal, advanced bool) rt.PhpVal {
	if rt.is_true(rt.call_function('is_callable', [rt.new_bool(advanced)])) {
		return rt.call_function('call_user_func', [rt.new_bool(advanced),
			var_html.clone()])
	}
	return rt.call_function('html_entity_decode', [
		rt.new_string(rt.call_function('strip_tags', [
			rt.call_function('preg_replace', [
				rt.new_string('/<(head|title|style|script)[^>]*>.*?<\\/\\1>/si'),
				rt.new_string(''),
				var_html.clone(),
			]),
		]).to_string().trim_space()),
		rt.get_constant('ENT_QUOTES'),
		this.CharSet,
	])
}

fn Class_PHPMailer_PHPMailer_PHPMailer._mime_types(ext string) string {
	mut ext_mutated := ext
	mut var_mimes := rt.create_array([
		rt.ArrayItem{ key: 'xl', val: 'application/excel' },
		rt.ArrayItem{ key: 'js', val: 'application/javascript' },
		rt.ArrayItem{ key: 'hqx', val: 'application/mac-binhex40' },
		rt.ArrayItem{ key: 'cpt', val: 'application/mac-compactpro' },
		rt.ArrayItem{ key: 'bin', val: 'application/macbinary' },
		rt.ArrayItem{ key: 'doc', val: 'application/msword' },
		rt.ArrayItem{ key: 'word', val: 'application/msword' },
		rt.ArrayItem{
			key: 'xlsx'
			val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
		},
		rt.ArrayItem{
			key: 'xltx'
			val: 'application/vnd.openxmlformats-officedocument.spreadsheetml.template'
		},
		rt.ArrayItem{
			key: 'potx'
			val: 'application/vnd.openxmlformats-officedocument.presentationml.template'
		},
		rt.ArrayItem{
			key: 'ppsx'
			val: 'application/vnd.openxmlformats-officedocument.presentationml.slideshow'
		},
		rt.ArrayItem{
			key: 'pptx'
			val: 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
		},
		rt.ArrayItem{
			key: 'sldx'
			val: 'application/vnd.openxmlformats-officedocument.presentationml.slide'
		},
		rt.ArrayItem{
			key: 'docx'
			val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
		},
		rt.ArrayItem{
			key: 'dotx'
			val: 'application/vnd.openxmlformats-officedocument.wordprocessingml.template'
		},
		rt.ArrayItem{ key: 'xlam', val: 'application/vnd.ms-excel.addin.macroEnabled.12' },
		rt.ArrayItem{ key: 'xlsb', val: 'application/vnd.ms-excel.sheet.binary.macroEnabled.12' },
		rt.ArrayItem{ key: 'class', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'dll', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'dms', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'exe', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'lha', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'lzh', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'psd', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'sea', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'so', val: 'application/octet-stream' },
		rt.ArrayItem{ key: 'oda', val: 'application/oda' },
		rt.ArrayItem{ key: 'pdf', val: 'application/pdf' },
		rt.ArrayItem{ key: 'ai', val: 'application/postscript' },
		rt.ArrayItem{ key: 'eps', val: 'application/postscript' },
		rt.ArrayItem{ key: 'ps', val: 'application/postscript' },
		rt.ArrayItem{ key: 'smi', val: 'application/smil' },
		rt.ArrayItem{ key: 'smil', val: 'application/smil' },
		rt.ArrayItem{ key: 'mif', val: 'application/vnd.mif' },
		rt.ArrayItem{ key: 'xls', val: 'application/vnd.ms-excel' },
		rt.ArrayItem{ key: 'ppt', val: 'application/vnd.ms-powerpoint' },
		rt.ArrayItem{ key: 'wbxml', val: 'application/vnd.wap.wbxml' },
		rt.ArrayItem{ key: 'wmlc', val: 'application/vnd.wap.wmlc' },
		rt.ArrayItem{ key: 'dcr', val: 'application/x-director' },
		rt.ArrayItem{ key: 'dir', val: 'application/x-director' },
		rt.ArrayItem{ key: 'dxr', val: 'application/x-director' },
		rt.ArrayItem{ key: 'dvi', val: 'application/x-dvi' },
		rt.ArrayItem{ key: 'gtar', val: 'application/x-gtar' },
		rt.ArrayItem{ key: 'php3', val: 'application/x-httpd-php' },
		rt.ArrayItem{ key: 'php4', val: 'application/x-httpd-php' },
		rt.ArrayItem{ key: 'php', val: 'application/x-httpd-php' },
		rt.ArrayItem{ key: 'phtml', val: 'application/x-httpd-php' },
		rt.ArrayItem{ key: 'phps', val: 'application/x-httpd-php-source' },
		rt.ArrayItem{ key: 'swf', val: 'application/x-shockwave-flash' },
		rt.ArrayItem{ key: 'sit', val: 'application/x-stuffit' },
		rt.ArrayItem{ key: 'tar', val: 'application/x-tar' },
		rt.ArrayItem{ key: 'tgz', val: 'application/x-tar' },
		rt.ArrayItem{ key: 'xht', val: 'application/xhtml+xml' },
		rt.ArrayItem{ key: 'xhtml', val: 'application/xhtml+xml' },
		rt.ArrayItem{ key: 'zip', val: 'application/zip' },
		rt.ArrayItem{ key: 'mid', val: 'audio/midi' },
		rt.ArrayItem{ key: 'midi', val: 'audio/midi' },
		rt.ArrayItem{ key: 'mp2', val: 'audio/mpeg' },
		rt.ArrayItem{ key: 'mp3', val: 'audio/mpeg' },
		rt.ArrayItem{ key: 'm4a', val: 'audio/mp4' },
		rt.ArrayItem{ key: 'mpga', val: 'audio/mpeg' },
		rt.ArrayItem{ key: 'aif', val: 'audio/x-aiff' },
		rt.ArrayItem{ key: 'aifc', val: 'audio/x-aiff' },
		rt.ArrayItem{ key: 'aiff', val: 'audio/x-aiff' },
		rt.ArrayItem{ key: 'ram', val: 'audio/x-pn-realaudio' },
		rt.ArrayItem{ key: 'rm', val: 'audio/x-pn-realaudio' },
		rt.ArrayItem{ key: 'rpm', val: 'audio/x-pn-realaudio-plugin' },
		rt.ArrayItem{ key: 'ra', val: 'audio/x-realaudio' },
		rt.ArrayItem{ key: 'wav', val: 'audio/x-wav' },
		rt.ArrayItem{ key: 'mka', val: 'audio/x-matroska' },
		rt.ArrayItem{ key: 'bmp', val: 'image/bmp' },
		rt.ArrayItem{ key: 'gif', val: 'image/gif' },
		rt.ArrayItem{ key: 'jpeg', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'jpe', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'jpg', val: 'image/jpeg' },
		rt.ArrayItem{ key: 'png', val: 'image/png' },
		rt.ArrayItem{ key: 'tiff', val: 'image/tiff' },
		rt.ArrayItem{ key: 'tif', val: 'image/tiff' },
		rt.ArrayItem{ key: 'webp', val: 'image/webp' },
		rt.ArrayItem{ key: 'avif', val: 'image/avif' },
		rt.ArrayItem{ key: 'heif', val: 'image/heif' },
		rt.ArrayItem{ key: 'heifs', val: 'image/heif-sequence' },
		rt.ArrayItem{ key: 'heic', val: 'image/heic' },
		rt.ArrayItem{ key: 'heics', val: 'image/heic-sequence' },
		rt.ArrayItem{ key: 'eml', val: 'message/rfc822' },
		rt.ArrayItem{ key: 'css', val: 'text/css' },
		rt.ArrayItem{ key: 'html', val: 'text/html' },
		rt.ArrayItem{ key: 'htm', val: 'text/html' },
		rt.ArrayItem{ key: 'shtml', val: 'text/html' },
		rt.ArrayItem{ key: 'log', val: 'text/plain' },
		rt.ArrayItem{ key: 'text', val: 'text/plain' },
		rt.ArrayItem{ key: 'txt', val: 'text/plain' },
		rt.ArrayItem{ key: 'rtx', val: 'text/richtext' },
		rt.ArrayItem{ key: 'rtf', val: 'text/rtf' },
		rt.ArrayItem{ key: 'vcf', val: 'text/vcard' },
		rt.ArrayItem{ key: 'vcard', val: 'text/vcard' },
		rt.ArrayItem{ key: 'ics', val: 'text/calendar' },
		rt.ArrayItem{ key: 'xml', val: 'text/xml' },
		rt.ArrayItem{ key: 'xsl', val: 'text/xml' },
		rt.ArrayItem{ key: 'csv', val: 'text/csv' },
		rt.ArrayItem{ key: 'wmv', val: 'video/x-ms-wmv' },
		rt.ArrayItem{ key: 'mpeg', val: 'video/mpeg' },
		rt.ArrayItem{ key: 'mpe', val: 'video/mpeg' },
		rt.ArrayItem{ key: 'mpg', val: 'video/mpeg' },
		rt.ArrayItem{ key: 'mp4', val: 'video/mp4' },
		rt.ArrayItem{ key: 'm4v', val: 'video/mp4' },
		rt.ArrayItem{ key: 'mov', val: 'video/quicktime' },
		rt.ArrayItem{ key: 'qt', val: 'video/quicktime' },
		rt.ArrayItem{ key: 'rv', val: 'video/vnd.rn-realvideo' },
		rt.ArrayItem{ key: 'avi', val: 'video/x-msvideo' },
		rt.ArrayItem{ key: 'movie', val: 'video/x-sgi-movie' },
		rt.ArrayItem{ key: 'webm', val: 'video/webm' },
		rt.ArrayItem{ key: 'mkv', val: 'video/x-matroska' },
	])
	ext_mutated = ext_mutated.to_lower()
	if rt.is_true(rt.new_bool(var_mimes.clone().array_isset(rt.new_string(ext_mutated).clone()))) {
		return (var_mimes.array_get(rt.new_string(ext_mutated))).str()
	}
	return 'application/octet-stream'
}

fn Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(var_filename rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
	mut var_qpos := rt.call_function('strpos', [var_filename_mutated.clone(),
		rt.new_string('?')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_qpos)))) {
		var_filename_mutated = rt.call_function('substr', [var_filename_mutated.clone(),
			rt.new_int(0), var_qpos.clone()])
	}
	mut var_ext := Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_filename_mutated.clone(),
		rt.get_constant('PATHINFO_EXTENSION'))
	return Class_PHPMailer_PHPMailer_PHPMailer._mime_types(var_ext.str())
}

fn Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_path rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_options_mutated := var_options
	mut var_ret := rt.create_array([rt.ArrayItem{ key: 'dirname', val: '' },
		rt.ArrayItem{ key: 'basename', val: '' }, rt.ArrayItem{ key: 'extension', val: '' },
		rt.ArrayItem{ key: 'filename', val: '' }])
	mut var_pathinfo := rt.new_array()
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('#^(.*?)[\\\\/]*(([^/\\\\]*?)(\\.([^.\\\\/]+?)|))[\\\\/.]*$#m'),
		var_path_mutated.clone(),
		var_pathinfo.clone(),
	]))
	{
		if rt.is_true(rt.new_bool(var_pathinfo.clone().array_isset(rt.new_int(1)))) {
			var_ret.array_set('dirname', var_pathinfo.array_get(rt.new_int(1)))
		}
		if rt.is_true(rt.new_bool(var_pathinfo.clone().array_isset(rt.new_int(2)))) {
			var_ret.array_set('basename', var_pathinfo.array_get(rt.new_int(2)))
		}
		if rt.is_true(rt.new_bool(var_pathinfo.clone().array_isset(rt.new_int(5)))) {
			var_ret.array_set('extension', var_pathinfo.array_get(rt.new_int(5)))
		}
		if rt.is_true(rt.new_bool(var_pathinfo.clone().array_isset(rt.new_int(3)))) {
			var_ret.array_set('filename', var_pathinfo.array_get(rt.new_int(3)))
		}
	}
	mut switch_val_11 := var_options_mutated
	if rt.is_true(rt.equal(switch_val_11, rt.get_constant('PATHINFO_DIRNAME')))
		|| rt.is_true(rt.equal(switch_val_11, rt.new_string('dirname'))) {
		return var_ret.array_get(rt.new_string('dirname'))
	} else if rt.is_true(rt.equal(switch_val_11, rt.get_constant('PATHINFO_BASENAME')))
		|| rt.is_true(rt.equal(switch_val_11, rt.new_string('basename'))) {
		return var_ret.array_get(rt.new_string('basename'))
	} else if rt.is_true(rt.equal(switch_val_11, rt.get_constant('PATHINFO_EXTENSION')))
		|| rt.is_true(rt.equal(switch_val_11, rt.new_string('extension'))) {
		return var_ret.array_get(rt.new_string('extension'))
	} else if rt.is_true(rt.equal(switch_val_11, rt.get_constant('PATHINFO_FILENAME')))
		|| rt.is_true(rt.equal(switch_val_11, rt.new_string('filename'))) {
		return var_ret.array_get(rt.new_string('filename'))
	} else {
		return var_ret.clone()
	}
	return rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) set(var_name rt.PhpVal, value string) bool {
	mut var_name_mutated := var_name
	mut value_mutated := value
	if rt.is_true(rt.call_function('property_exists', [
		rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this),
		var_name_mutated.clone(),
	]))
	{
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":5014,"name":"name"}',
			rt.new_string(value_mutated).clone())
		return true
	}
	this.seterror(rt.new_string(
		(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('variable_set'))).str() +
		var_name_mutated.str()))
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) secureheader(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '\r' },
			rt.ArrayItem{ key: none, val: '\n' }]),
		rt.new_string(''),
		var_str_mutated.clone(),
	]).to_string().trim_space()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_text rt.PhpVal, var_breaktype rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	mut var_breaktype_mutated := var_breaktype
	if rt.is_true(rt.identical(rt.new_null(), var_breaktype_mutated)) {
		var_breaktype_mutated = rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')
	}
	var_text_mutated = rt.call_function('str_replace', [
		rt.create_array([
			rt.ArrayItem{
				key: none
				val: Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf()
			},
			rt.ArrayItem{ key: none, val: '\r' },
		]),
		rt.new_string('\n'),
		var_text_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('\n'), var_breaktype_mutated)))) {
		var_text_mutated = rt.call_function('str_replace', [rt.new_string('\n'),
			var_breaktype_mutated.clone(), var_text_mutated.clone()])
	}
	return var_text_mutated.clone()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(var_text rt.PhpVal) string {
	mut var_text_mutated := var_text
	return var_text_mutated.clone().to_string().trim_right(' \t\n\r')
}

fn Class_PHPMailer_PHPMailer_PHPMailer.striptrailingbreaks(var_text rt.PhpVal) string {
	mut var_text_mutated := var_text
	return var_text_mutated.clone().to_string().trim_right(' \t\n\r')
}

fn Class_PHPMailer_PHPMailer_PHPMailer.getle() rt.PhpVal {
	return rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')
}

fn Class_PHPMailer_PHPMailer_PHPMailer.setle(var_le rt.PhpVal) {
	rt.set_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE', var_le.clone())
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) sign(var_cert_filename rt.PhpVal, var_key_filename rt.PhpVal, var_key_pass rt.PhpVal, extracerts_filename string) {
	this.sign_cert_file = var_cert_filename.clone()
	this.sign_key_file = var_key_filename.clone()
	this.sign_key_pass = var_key_pass.clone()
	this.sign_extracerts_file = rt.new_string(extracerts_filename)
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_qp(var_txt rt.PhpVal) rt.PhpVal {
	mut var_line := rt.new_string('')
	mut var_len := rt.new_int(var_txt.clone().to_string().len)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, var_len))) { break
		 }
		mut var_ord := rt.call_function('ord', [var_txt.array_get(var_i)])
		if ((rt.is_true(rt.less_equal(rt.new_int(33), var_ord))
			&& rt.is_true(rt.less_equal(var_ord, rt.new_int(58))))
			|| rt.is_true(rt.identical(var_ord, rt.new_int(60))))
			|| (rt.is_true(rt.less_equal(rt.new_int(62), var_ord))
			&& rt.is_true(rt.less_equal(var_ord, rt.new_int(126)))) {
			var_line = rt.concat(var_line, var_txt.array_get(var_i))
		} else {
			var_line = rt.concat(var_line, rt.new_string('=' +
				(rt.call_function('sprintf', [rt.new_string('%02X'), var_ord.clone()])).str()))
		}
		rt.pre_inc(var_i)
	}
	return var_line.clone()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_sign(var_signHeader rt.PhpVal) string {
	mut var_signature := rt.new_null()
	mut var_signHeader_mutated := var_signHeader
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('PKCS7_TEXT'),
	])))))
	{
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(
				(Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('extension_missing'))).str() + 'openssl')))
		}
		return ''
	}
	mut var_privKeyStr := if !(!rt.is_true(this.DKIM_private_string)) { this.DKIM_private_string } else { rt.call_function('file_get_contents', [
			this.DKIM_private,
		]) }
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.DKIM_passphrase)))) {
		mut var_privKey := rt.call_function('openssl_pkey_get_private', [
			var_privKeyStr.clone(), this.DKIM_passphrase])
	} else {
		var_privKey = rt.call_function('openssl_pkey_get_private', [
			var_privKeyStr.clone()])
	}
	if rt.is_true(rt.call_function('openssl_sign', [var_signHeader_mutated.clone(),
		var_signature.clone(), var_privKey.clone(), rt.new_string('sha256WithRSAEncryption')]))
	{
		if rt.is_true(rt.less(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(8))) {
			rt.call_function('openssl_pkey_free', [var_privKey.clone()])
		}
		return (rt.call_function('base64_encode', [var_signature.clone()])).str()
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_MAJOR_VERSION'), rt.new_int(8))) {
		rt.call_function('openssl_pkey_free', [var_privKey.clone()])
	}
	return ''
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_headerc(var_signHeader rt.PhpVal) rt.PhpVal {
	mut var_signHeader_mutated := var_signHeader
	var_signHeader_mutated = Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_signHeader_mutated.clone(),
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf())
	var_signHeader_mutated = rt.call_function('preg_replace', [
		rt.new_string('/\\r\\n[ \\t]+/'),
		rt.new_string(' '),
		var_signHeader_mutated.clone(),
	])
	mut var_lines := rt.call_function('explode', [
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf(),
		var_signHeader_mutated.clone(),
	])
	mut iter_37 := var_lines.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_line := item_37.val
		mut var_key := item_37.key
		if rt.is_true(rt.identical(rt.call_function('strpos', [
			var_line.clone(), rt.new_string(':')]), rt.new_bool(false)))
		{
			continue
		}
		mut list_tmp_4 := rt.call_function('explode', [rt.new_string(':'),
			var_line.clone(), rt.new_int(2)])
		mut var_heading := list_tmp_4.array_get(0)
		mut var_value := list_tmp_4.array_get(1)
		var_heading = rt.new_string(var_heading.clone().to_string().to_lower())
		var_value = rt.call_function('preg_replace', [rt.new_string('/[ \\t]+/'),
			rt.new_string(' '), var_value.clone()])
		var_lines.array_set(var_key, var_heading.clone().to_string().trim_space() + ':' +
			var_value.clone().to_string().trim_space())
	}
	return rt.call_function('implode', [
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf(),
		var_lines.clone(),
	])
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_bodyc(var_body rt.PhpVal) string {
	mut var_body_mutated := var_body
	if !rt.is_true(var_body_mutated) {
		return (Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf()).str()
	}
	var_body_mutated = Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_body_mutated.clone(),
		Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf())
	return
		(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingbreaks(var_body_mutated.clone())).str() +
		(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.crlf()).str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_add(var_headers_line rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
	mut var_DKIMsignatureType := rt.new_string('rsa-sha256')
	mut var_DKIMcanonicalization := rt.new_string('relaxed/simple')
	mut var_DKIMquery := rt.new_string('dns/txt')
	mut var_DKIMtime := rt.call_function('time', []rt.PhpVal{})
	mut var_autoSignHeaders := rt.create_array([rt.ArrayItem{ key: none, val: 'from' },
		rt.ArrayItem{ key: none, val: 'to' }, rt.ArrayItem{ key: none, val: 'cc' },
		rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'subject' },
		rt.ArrayItem{ key: none, val: 'reply-to' }, rt.ArrayItem{ key: none, val: 'message-id' },
		rt.ArrayItem{ key: none, val: 'content-type' }, rt.ArrayItem{ key: none, val: 'mime-version' },
		rt.ArrayItem{ key: none, val: 'x-mailer' }])
	if rt.is_true(rt.identical(rt.call_function('stripos', [var_headers_line.clone(),
		rt.new_string('Subject')]), rt.new_bool(false)))
	{
		var_headers_line = rt.concat(var_headers_line, rt.new_string('Subject: ' +
			var_subject_mutated.str() +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()))
	}
	mut var_headerLines := rt.call_function('explode', [
		rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
		var_headers_line.clone(),
	])
	mut var_currentHeaderLabel := rt.new_string('')
	mut var_currentHeaderValue := rt.new_string('')
	mut var_parsedHeaders := rt.new_array()
	mut var_headerLineIndex := rt.new_int(0)
	mut var_headerLineCount := rt.new_int(var_headerLines.clone().array_count())
	mut iter_38 := var_headerLines.iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_headerLine := item_38.val
		mut var_matches := rt.new_array()
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^([^ \\t]*?)(?::[ \\t]*)(.*)$/'),
			var_headerLine.clone(),
			var_matches.clone(),
		]))
		{
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_currentHeaderLabel,
				rt.new_string('')))))
			{
				var_parsedHeaders.array_push(rt.create_array([
					rt.ArrayItem{ key: 'label', val: var_currentHeaderLabel },
					rt.ArrayItem{ key: 'value', val: var_currentHeaderValue },
				]))
			}
			var_currentHeaderLabel = var_matches.array_get(rt.new_int(1))
			var_currentHeaderValue = var_matches.array_get(rt.new_int(2))
		} else if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^[ \\t]+(.*)$/'),
			var_headerLine.clone(),
			var_matches.clone(),
		]))
		{
			var_currentHeaderValue = rt.concat(var_currentHeaderValue, rt.new_string(' ' +
				(var_matches.array_get(rt.new_int(1))).str()))
		}
		rt.pre_inc(var_headerLineIndex)
		if rt.is_true(rt.greater_equal(var_headerLineIndex, var_headerLineCount)) {
			var_parsedHeaders.array_push(rt.create_array([
				rt.ArrayItem{ key: 'label', val: var_currentHeaderLabel },
				rt.ArrayItem{ key: 'value', val: var_currentHeaderValue },
			]))
		}
	}
	mut var_copiedHeaders := rt.new_array()
	mut var_headersToSignKeys := rt.new_array()
	mut var_headersToSign := rt.new_array()
	mut iter_39 := var_parsedHeaders.iterator()
	for {
		item_39 := iter_39.next() or { break }
		mut var_header := item_39.val
		if rt.is_true(rt.call_function('in_array', [
			rt.new_string(var_header.array_get(rt.new_string('label')).to_string().to_lower()),
			var_autoSignHeaders.clone(),
			rt.new_bool(true),
		]))
		{
			var_headersToSignKeys.array_push(var_header.array_get(rt.new_string('label')))
			var_headersToSign.array_push((var_header.array_get(rt.new_string('label'))).str() +
				': ' + (var_header.array_get(rt.new_string('value'))).str())
			if rt.is_true(this.DKIM_copyHeaderFields) {
				var_copiedHeaders.array_push((var_header.array_get(rt.new_string('label'))).str() +
					':' +(rt.call_function('str_replace', [rt.new_string('|'), rt.new_string('=7C'), this.dkim_qp(var_header.array_get(rt.new_string('value')))])).str())
			}
			continue
		}
		if rt.is_true(rt.call_function('in_array', [var_header.array_get(rt.new_string('label')),
			this.DKIM_extraHeaders, rt.new_bool(true)]))
		{
			mut iter_40 := this.CustomHeader.iterator()
			for {
				item_40 := iter_40.next() or { break }
				mut var_customHeader := item_40.val
				if rt.is_true(rt.identical(var_customHeader.array_get(rt.new_int(0)),
					var_header.array_get(rt.new_string('label'))))
				{
					var_headersToSignKeys.array_push(var_header.array_get(rt.new_string('label')))
					var_headersToSign.array_push(
						(var_header.array_get(rt.new_string('label'))).str() + ': ' +
						(var_header.array_get(rt.new_string('value'))).str())
					if rt.is_true(this.DKIM_copyHeaderFields) {
						var_copiedHeaders.array_push(
							(var_header.array_get(rt.new_string('label'))).str() + ':' +(rt.call_function('str_replace', [rt.new_string('|'), rt.new_string('=7C'), this.dkim_qp(var_header.array_get(rt.new_string('value')))])).str())
					}
					continue
				}
			}
		}
	}
	mut var_copiedHeaderFields := rt.new_string('')
	if rt.is_true(this.DKIM_copyHeaderFields) && var_copiedHeaders.clone().array_count() > 0 {
		var_copiedHeaderFields = rt.new_string(' z=')
		mut var_first := rt.new_bool(true)
		mut iter_41 := var_copiedHeaders.iterator()
		for {
			item_41 := iter_41.next() or { break }
			mut var_copiedHeader := item_41.val
			if rt.is_true(rt.new_bool(!(rt.is_true(var_first)))) {
				var_copiedHeaderFields = rt.concat(var_copiedHeaderFields, rt.new_string(
					(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() + ' |'))
			}
			if rt.is_true(rt.greater(rt.new_int(var_copiedHeader.clone().to_string().len), rt.sub(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.std_line_length(),
				rt.new_int(3))))
			{
				var_copiedHeaderFields = rt.concat(var_copiedHeaderFields, rt.call_function('substr', [
					rt.call_function('chunk_split', [var_copiedHeader.clone(),
						rt.sub(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.std_line_length(),
							rt.new_int(3)),
						rt.new_string(
							(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
							(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.fws()).str())]),
					rt.new_int(0),
					rt.new_int(-(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
						(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.fws()).str().len),
				]))
			} else {
				var_copiedHeaderFields = rt.concat(var_copiedHeaderFields, var_copiedHeader)
			}
			var_first = rt.new_bool(false)
		}
		var_copiedHeaderFields = rt.concat(var_copiedHeaderFields, rt.new_string(';' +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str()))
	}
	mut var_headerKeys := rt.new_string(' h=' +
		(rt.call_function('implode', [rt.new_string(':'), var_headersToSignKeys.clone()])).str() +
		';' + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
	mut var_headerValues := rt.call_function('implode', [
		rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE'),
		var_headersToSign.clone(),
	])
	var_body_mutated = rt.new_string(this.dkim_bodyc(var_body_mutated.clone()))
	mut var_DKIMb64 := rt.call_function('base64_encode', [
		rt.call_function('pack', [rt.new_string('H*'),
			rt.call_function('hash', [rt.new_string('sha256'),
				var_body_mutated.clone()])]),
	])
	mut var_ident := rt.new_string('')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), this.DKIM_identity)))) {
		var_ident = rt.new_string(' i=' +(this.DKIM_identity).str() + ';' +
			(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str())
	}
	mut var_dkimSignatureHeader := rt.new_string('DKIM-Signature: v=1;' + ' d=' +
		(this.DKIM_domain).str() + ';' + ' s=' + (this.DKIM_selector).str() + ';' + (rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		' a=' + var_DKIMsignatureType.str() + ';' + ' q=' + var_DKIMquery.str() + ';' + ' t=' +
		var_DKIMtime.str() + ';' + ' c=' + var_DKIMcanonicalization.str() + ';' +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() + var_headerKeys.str() +
		var_ident.str() + var_copiedHeaderFields.str() + ' bh=' + var_DKIMb64.str() + ';' +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() + ' b=')
	mut var_canonicalizedHeaders := this.dkim_headerc(rt.new_string(var_headerValues.str() +
		(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
		var_dkimSignatureHeader.str()))
	mut var_signature := rt.new_string(this.dkim_sign(var_canonicalizedHeaders.clone()))
	var_signature = rt.new_string(rt.call_function('chunk_split', [
		var_signature.clone(),
		rt.sub(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.std_line_length(),
			rt.new_int(3)),
		rt.new_string((rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE')).str() +
			(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.fws()).str())]).to_string().trim_space())
	return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(rt.new_string(
		var_dkimSignatureHeader.str() + var_signature.str()))
}

fn Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(var_str rt.PhpVal) bool {
	mut var_str_mutated := var_str
	return (rt.call_function('preg_match', [
		rt.new_string('/^(.{' +
			(rt.add(Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.max_line_length(), rt.new_int(rt.get_static_prop('PHPMailer_PHPMailer_PHPMailer', 'LE').to_string().len))).str() +
			',})/m'),
		var_str_mutated.clone(),
	])).to_bool()
}

fn Class_PHPMailer_PHPMailer_PHPMailer.quotedstring(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/[ ()<>@,;:"\\/\\[\\]?=]/'),
		var_str_mutated.clone(),
	]))
	{
		return '"' +
			(rt.call_function('str_replace', [rt.new_string('"'), rt.new_string('\\"'), var_str_mutated.clone()])).str() +
			'"'
	}
	return var_str_mutated.str()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) gettoaddresses() rt.PhpVal {
	return this.to
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getccaddresses() rt.PhpVal {
	return this.cc
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getbccaddresses() rt.PhpVal {
	return this.bcc
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getreplytoaddresses() rt.PhpVal {
	return this.ReplyTo
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getallrecipientaddresses() rt.PhpVal {
	return this.all_recipients
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) docallback(var_isSent rt.PhpVal, var_to rt.PhpVal, var_cc rt.PhpVal, var_bcc rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal, var_from rt.PhpVal, var_extra rt.PhpVal) {
	mut var_isSent_mutated := var_isSent
	mut var_to_mutated := var_to
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
	if !(!rt.is_true(this.action_function))
		&& rt.call_function('is_callable', [this.action_function]) {
		rt.call_function('call_user_func', [this.action_function, var_isSent_mutated.clone(),
			var_to_mutated.clone(), var_cc.clone(), var_bcc.clone(),
			var_subject_mutated.clone(), var_body_mutated.clone(),
			var_from.clone(), var_extra.clone()])
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getoauth() rt.PhpVal {
	return this.oauth
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setoauth(mut var_oauth Class_PHPMailer_PHPMailer_OAuthTokenProvider) {
	this.oauth = var_oauth
}

struct Class_PHPMailer_PHPMailer_Exception {
	rt.PhpObjectBase
}

struct Class_PHPMailer_PHPMailer_SMTP {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_phpmailer(arg_0 rt.PhpVal) &Class_PHPMailer_PHPMailer_PHPMailer {
	mut obj := &Class_PHPMailer_PHPMailer_PHPMailer{
		PhpObjectBase:         rt.PhpObjectBase{}
		Priority:              rt.new_null()
		CharSet:               rt.new_null()
		ContentType:           rt.new_null()
		Encoding:              rt.new_null()
		ErrorInfo:             rt.new_string('')
		From:                  rt.new_string('')
		FromName:              rt.new_string('')
		Sender:                rt.new_string('')
		Subject:               ''
		Body:                  rt.new_string('')
		AltBody:               rt.new_string('')
		Ical:                  rt.new_string('')
		MIMEBody:              rt.new_string('')
		MIMEHeader:            rt.new_string('')
		mailHeader:            ''
		WordWrap:              rt.new_int(0)
		Mailer:                ''
		Sendmail:              rt.new_string('/usr/sbin/sendmail')
		UseSendmailOptions:    rt.new_bool(true)
		ConfirmReadingTo:      rt.new_string('')
		Hostname:              rt.new_string('')
		MessageID:             rt.new_string('')
		MessageDate:           rt.new_string('')
		Host:                  ''
		Port:                  rt.new_int(25)
		Helo:                  rt.new_string('')
		SMTPSecure:            rt.new_string('')
		SMTPAutoTLS:           rt.new_bool(true)
		SMTPAuth:              rt.new_bool(false)
		SMTPOptions:           rt.new_array()
		Username:              rt.new_string('')
		Password:              rt.new_string('')
		AuthType:              rt.new_string('')
		SMTPXClient:           rt.new_array()
		oauth:                 rt.new_null()
		Timeout:               rt.new_int(300)
		dsn:                   rt.new_string('')
		SMTPDebug:             rt.new_int(0)
		Debugoutput:           ''
		SMTPKeepAlive:         rt.new_bool(false)
		SingleTo:              rt.new_bool(false)
		SingleToArray:         rt.new_array()
		do_verp:               rt.new_bool(false)
		AllowEmpty:            rt.new_bool(false)
		DKIM_selector:         rt.new_string('')
		DKIM_identity:         rt.new_string('')
		DKIM_passphrase:       rt.new_string('')
		DKIM_domain:           rt.new_string('')
		DKIM_copyHeaderFields: rt.new_bool(true)
		DKIM_extraHeaders:     rt.new_array()
		DKIM_private:          rt.new_string('')
		DKIM_private_string:   rt.new_string('')
		action_function:       rt.new_string('')
		XMailer:               rt.new_string('')
		smtp:                  rt.new_null()
		to:                    rt.new_array()
		cc:                    rt.new_array()
		bcc:                   rt.new_array()
		ReplyTo:               rt.new_array()
		all_recipients:        rt.new_array()
		RecipientsQueue:       rt.new_array()
		ReplyToQueue:          rt.new_array()
		UseSMTPUTF8:           false
		attachment:            rt.new_array()
		CustomHeader:          rt.new_array()
		lastMessageID:         rt.new_string('')
		message_type:          rt.new_string('')
		boundary:              rt.new_array()
		error_count:           i64(0)
		sign_cert_file:        rt.new_string('')
		sign_key_file:         rt.new_string('')
		sign_extracerts_file:  rt.new_string('')
		sign_key_pass:         rt.new_string('')
		exceptions:            rt.new_bool(false)
		uniqueid:              rt.new_string('')
	}
	obj.construct(arg_0)
	return obj
}

fn create_phpmailer_phpmailer_exception(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_Exception {
	mut obj := &Class_PHPMailer_PHPMailer_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_phpmailer_phpmailer_smtp(_args ...rt.PhpVal) &Class_PHPMailer_PHPMailer_SMTP {
	mut obj := &Class_PHPMailer_PHPMailer_SMTP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'mailPassthru' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.mailpassthru(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'edebug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.edebug(dispatch_arg_0)
			return rt.new_null()
		}
		'isHTML' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.ishtml(dispatch_arg_0)
			return rt.new_null()
		}
		'isSMTP' {
			this.issmtp()
			return rt.new_null()
		}
		'isMail' {
			this.ismail()
			return rt.new_null()
		}
		'parseSendmailPath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parsesendmailpath(dispatch_arg_0)
		}
		'isSendmail' {
			this.issendmail()
			return rt.new_null()
		}
		'isQmail' {
			this.isqmail()
			return rt.new_null()
		}
		'addAddress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.addaddress(dispatch_arg_0, dispatch_arg_1)
		}
		'addCC' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.addcc(dispatch_arg_0, dispatch_arg_1)
		}
		'addBCC' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.addbcc(dispatch_arg_0, dispatch_arg_1)
		}
		'addReplyTo' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.addreplyto(dispatch_arg_0, dispatch_arg_1)
		}
		'addOrEnqueueAnAddress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.addorenqueueanaddress(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'setBoundaries' {
			this.setboundaries()
			return rt.new_null()
		}
		'addAnAddress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.addanaddress(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'parseAddresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'parseSimplerAddresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.parsesimpleraddresses(dispatch_arg_0,
				dispatch_arg_1)
		}
		'parseEmailString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.parseemailstring(dispatch_arg_0)
		}
		'setFrom' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.setfrom(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'getLastMessageID' {
			return this.getlastmessageid()
		}
		'validateAddress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(dispatch_arg_0,
				dispatch_arg_1))
		}
		'idnSupported' {
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.idnsupported())
		}
		'punyencodeAddress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.punyencodeaddress(dispatch_arg_0))
		}
		'send' {
			return rt.new_bool(this.send())
		}
		'preSend' {
			return rt.new_bool(this.presend())
		}
		'postSend' {
			return rt.new_bool(this.postsend())
		}
		'sendmailSend' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.sendmailsend(dispatch_arg_0, dispatch_arg_1))
		}
		'isShellSafe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.isshellsafe(dispatch_arg_0))
		}
		'isPermittedPath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.ispermittedpath(dispatch_arg_0))
		}
		'fileIsAccessible' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(dispatch_arg_0))
		}
		'mailSend' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.mailsend(dispatch_arg_0, dispatch_arg_1))
		}
		'getSMTPInstance' {
			return this.getsmtpinstance()
		}
		'setSMTPInstance' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_SMTP](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.setsmtpinstance(mut dispatch_arg_0)
		}
		'setSMTPXclientAttribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.setsmtpxclientattribute(dispatch_arg_0, dispatch_arg_1))
		}
		'getSMTPXclientAttributes' {
			return this.getsmtpxclientattributes()
		}
		'smtpSend' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.smtpsend(dispatch_arg_0, dispatch_arg_1))
		}
		'smtpConnect' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.smtpconnect(dispatch_arg_0))
		}
		'smtpClose' {
			this.smtpclose()
			return rt.new_null()
		}
		'setLanguage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_PHPMailer_PHPMailer_PHPMailer.setlanguage(dispatch_arg_0, dispatch_arg_1)
		}
		'getTranslations' {
			return this.gettranslations()
		}
		'addrAppend' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.addrappend(dispatch_arg_0, dispatch_arg_1))
		}
		'addrFormat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.addrformat(dispatch_arg_0))
		}
		'wrapText' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.wraptext(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'utf8CharBoundary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.utf8charboundary(dispatch_arg_0, dispatch_arg_1)
		}
		'setWordWrap' {
			this.setwordwrap()
			return rt.new_null()
		}
		'createHeader' {
			return this.createheader()
		}
		'getMailMIME' {
			return this.getmailmime()
		}
		'getSentMIMEMessage' {
			return rt.new_string(this.getsentmimemessage())
		}
		'generateId' {
			return this.generateid()
		}
		'createBody' {
			return this.createbody()
		}
		'getBoundaries' {
			return this.getboundaries()
		}
		'getBoundary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.getboundary(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'endBoundary' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.endboundary(dispatch_arg_0))
		}
		'setMessageType' {
			this.setmessagetype()
			return rt.new_null()
		}
		'headerLine' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.headerline(dispatch_arg_0, dispatch_arg_1))
		}
		'textLine' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.textline(dispatch_arg_0))
		}
		'addAttachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_bool(this.addattachment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4))
		}
		'getAttachments' {
			return this.getattachments()
		}
		'attachAll' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.attachall(dispatch_arg_0, dispatch_arg_1))
		}
		'encodeFile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.encodefile(dispatch_arg_0, dispatch_arg_1))
		}
		'encodeString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.encodestring(dispatch_arg_0, dispatch_arg_1)
		}
		'encodeHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.encodeheader(dispatch_arg_0, dispatch_arg_1))
		}
		'decodeHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(dispatch_arg_0,
				dispatch_arg_1))
		}
		'hasMultiBytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hasmultibytes(dispatch_arg_0))
		}
		'has8bitChars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has8bitchars(dispatch_arg_0))
		}
		'base64EncodeWrapMB' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.base64encodewrapmb(dispatch_arg_0, dispatch_arg_1)
		}
		'encodeQP' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encodeqp(dispatch_arg_0)
		}
		'encodeQ' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.encodeq(dispatch_arg_0, dispatch_arg_1)
		}
		'addStringAttachment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			return rt.new_bool(this.addstringattachment(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'addEmbeddedImage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this.addembeddedimage(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'addStringEmbeddedImage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this.addstringembeddedimage(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'validateEncoding' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validateencoding(dispatch_arg_0)
		}
		'cidExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.cidexists(dispatch_arg_0))
		}
		'inlineImageExists' {
			return rt.new_bool(this.inlineimageexists())
		}
		'attachmentExists' {
			return rt.new_bool(this.attachmentexists())
		}
		'alternativeExists' {
			return rt.new_bool(this.alternativeexists())
		}
		'clearQueuedAddresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clearqueuedaddresses(dispatch_arg_0)
			return rt.new_null()
		}
		'clearAddresses' {
			this.clearaddresses()
			return rt.new_null()
		}
		'clearCCs' {
			this.clearccs()
			return rt.new_null()
		}
		'clearBCCs' {
			this.clearbccs()
			return rt.new_null()
		}
		'clearReplyTos' {
			this.clearreplytos()
			return rt.new_null()
		}
		'clearAllRecipients' {
			this.clearallrecipients()
			return rt.new_null()
		}
		'clearAttachments' {
			this.clearattachments()
			return rt.new_null()
		}
		'clearCustomHeaders' {
			this.clearcustomheaders()
			return rt.new_null()
		}
		'clearCustomHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.clearcustomheader(dispatch_arg_0, dispatch_arg_1))
		}
		'replaceCustomHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.replacecustomheader(dispatch_arg_0, dispatch_arg_1))
		}
		'setError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.seterror(dispatch_arg_0)
			return rt.new_null()
		}
		'rfcDate' {
			return Class_PHPMailer_PHPMailer_PHPMailer.rfcdate()
		}
		'serverHostname' {
			return rt.new_string(this.serverhostname())
		}
		'isValidHost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.isvalidhost(dispatch_arg_0))
		}
		'addressHasUnicodeLocalPart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.addresshasunicodelocalpart(dispatch_arg_0))
		}
		'anyAddressHasUnicodeLocalPart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.anyaddresshasunicodelocalpart(dispatch_arg_0))
		}
		'needsSMTPUTF8' {
			return rt.new_bool(this.needssmtputf8())
		}
		'lang' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.lang(dispatch_arg_0))
		}
		'getSmtpErrorMessage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getsmtperrormessage(dispatch_arg_0)
		}
		'isError' {
			return this.iserror()
		}
		'addCustomHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.addcustomheader(dispatch_arg_0, dispatch_arg_1))
		}
		'getCustomHeaders' {
			return this.getcustomheaders()
		}
		'msgHTML' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.msghtml(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'html2text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.html2text(dispatch_arg_0, dispatch_arg_1)
		}
		'_mime_types' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer._mime_types(dispatch_arg_0))
		}
		'filenameToType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(dispatch_arg_0)
		}
		'mb_pathinfo' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(dispatch_arg_0, dispatch_arg_1)
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1))
		}
		'secureHeader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.secureheader(dispatch_arg_0))
		}
		'normalizeBreaks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(dispatch_arg_0,
				dispatch_arg_1)
		}
		'stripTrailingWSP' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(dispatch_arg_0))
		}
		'stripTrailingBreaks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.striptrailingbreaks(dispatch_arg_0))
		}
		'getLE' {
			return Class_PHPMailer_PHPMailer_PHPMailer.getle()
		}
		'setLE' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_PHPMailer_PHPMailer_PHPMailer.setle(dispatch_arg_0)
			return rt.new_null()
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.sign(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'DKIM_QP' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dkim_qp(dispatch_arg_0)
		}
		'DKIM_Sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.dkim_sign(dispatch_arg_0))
		}
		'DKIM_HeaderC' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dkim_headerc(dispatch_arg_0)
		}
		'DKIM_BodyC' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.dkim_bodyc(dispatch_arg_0))
		}
		'DKIM_Add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.dkim_add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'hasLineLongerThanMax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(dispatch_arg_0))
		}
		'quotedString' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.quotedstring(dispatch_arg_0))
		}
		'getToAddresses' {
			return this.gettoaddresses()
		}
		'getCcAddresses' {
			return this.getccaddresses()
		}
		'getBccAddresses' {
			return this.getbccaddresses()
		}
		'getReplyToAddresses' {
			return this.getreplytoaddresses()
		}
		'getAllRecipientAddresses' {
			return this.getallrecipientaddresses()
		}
		'doCallback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			dispatch_arg_6 := if args.len > 6 { args[6] } else { rt.new_null() }
			dispatch_arg_7 := if args.len > 7 { args[7] } else { rt.new_null() }
			this.docallback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
			return rt.new_null()
		}
		'getOAuth' {
			return this.getoauth()
		}
		'setOAuth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_OAuthTokenProvider](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.setoauth(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_PHPMailer_PHPMailer_PHPMailer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'Priority' { return this.Priority }
		'CharSet' { return this.CharSet }
		'ContentType' { return this.ContentType }
		'Encoding' { return this.Encoding }
		'ErrorInfo' { return this.ErrorInfo }
		'From' { return this.From }
		'FromName' { return this.FromName }
		'Sender' { return this.Sender }
		'Subject' { return rt.new_string(this.Subject) }
		'Body' { return this.Body }
		'AltBody' { return this.AltBody }
		'Ical' { return this.Ical }
		'MIMEBody' { return this.MIMEBody }
		'MIMEHeader' { return this.MIMEHeader }
		'mailHeader' { return rt.new_string(this.mailHeader) }
		'WordWrap' { return this.WordWrap }
		'Mailer' { return rt.new_string(this.Mailer) }
		'Sendmail' { return this.Sendmail }
		'UseSendmailOptions' { return this.UseSendmailOptions }
		'ConfirmReadingTo' { return this.ConfirmReadingTo }
		'Hostname' { return this.Hostname }
		'MessageID' { return this.MessageID }
		'MessageDate' { return this.MessageDate }
		'Host' { return rt.new_string(this.Host) }
		'Port' { return this.Port }
		'Helo' { return this.Helo }
		'SMTPSecure' { return this.SMTPSecure }
		'SMTPAutoTLS' { return this.SMTPAutoTLS }
		'SMTPAuth' { return this.SMTPAuth }
		'SMTPOptions' { return this.SMTPOptions }
		'Username' { return this.Username }
		'Password' { return this.Password }
		'AuthType' { return this.AuthType }
		'SMTPXClient' { return this.SMTPXClient }
		'oauth' { return this.oauth }
		'Timeout' { return this.Timeout }
		'dsn' { return this.dsn }
		'SMTPDebug' { return this.SMTPDebug }
		'Debugoutput' { return rt.new_string(this.Debugoutput) }
		'SMTPKeepAlive' { return this.SMTPKeepAlive }
		'SingleTo' { return this.SingleTo }
		'SingleToArray' { return this.SingleToArray }
		'do_verp' { return this.do_verp }
		'AllowEmpty' { return this.AllowEmpty }
		'DKIM_selector' { return this.DKIM_selector }
		'DKIM_identity' { return this.DKIM_identity }
		'DKIM_passphrase' { return this.DKIM_passphrase }
		'DKIM_domain' { return this.DKIM_domain }
		'DKIM_copyHeaderFields' { return this.DKIM_copyHeaderFields }
		'DKIM_extraHeaders' { return this.DKIM_extraHeaders }
		'DKIM_private' { return this.DKIM_private }
		'DKIM_private_string' { return this.DKIM_private_string }
		'action_function' { return this.action_function }
		'XMailer' { return this.XMailer }
		'smtp' { return this.smtp }
		'to' { return this.to }
		'cc' { return this.cc }
		'bcc' { return this.bcc }
		'ReplyTo' { return this.ReplyTo }
		'all_recipients' { return this.all_recipients }
		'RecipientsQueue' { return this.RecipientsQueue }
		'ReplyToQueue' { return this.ReplyToQueue }
		'UseSMTPUTF8' { return rt.new_bool(this.UseSMTPUTF8) }
		'attachment' { return this.attachment }
		'CustomHeader' { return this.CustomHeader }
		'lastMessageID' { return this.lastMessageID }
		'message_type' { return this.message_type }
		'boundary' { return this.boundary }
		'error_count' { return rt.new_int(this.error_count) }
		'sign_cert_file' { return this.sign_cert_file }
		'sign_key_file' { return this.sign_key_file }
		'sign_extracerts_file' { return this.sign_extracerts_file }
		'sign_key_pass' { return this.sign_key_pass }
		'exceptions' { return this.exceptions }
		'uniqueid' { return this.uniqueid }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'Priority' {
			this.Priority = val
			return true
		}
		'CharSet' {
			this.CharSet = val
			return true
		}
		'ContentType' {
			this.ContentType = val
			return true
		}
		'Encoding' {
			this.Encoding = val
			return true
		}
		'ErrorInfo' {
			this.ErrorInfo = val
			return true
		}
		'From' {
			this.From = val
			return true
		}
		'FromName' {
			this.FromName = val
			return true
		}
		'Sender' {
			this.Sender = val
			return true
		}
		'Subject' {
			this.Subject = val.str()
			return true
		}
		'Body' {
			this.Body = val
			return true
		}
		'AltBody' {
			this.AltBody = val
			return true
		}
		'Ical' {
			this.Ical = val
			return true
		}
		'MIMEBody' {
			this.MIMEBody = val
			return true
		}
		'MIMEHeader' {
			this.MIMEHeader = val
			return true
		}
		'mailHeader' {
			this.mailHeader = val.str()
			return true
		}
		'WordWrap' {
			this.WordWrap = val
			return true
		}
		'Mailer' {
			this.Mailer = val.str()
			return true
		}
		'Sendmail' {
			this.Sendmail = val
			return true
		}
		'UseSendmailOptions' {
			this.UseSendmailOptions = val
			return true
		}
		'ConfirmReadingTo' {
			this.ConfirmReadingTo = val
			return true
		}
		'Hostname' {
			this.Hostname = val
			return true
		}
		'MessageID' {
			this.MessageID = val
			return true
		}
		'MessageDate' {
			this.MessageDate = val
			return true
		}
		'Host' {
			this.Host = val.str()
			return true
		}
		'Port' {
			this.Port = val
			return true
		}
		'Helo' {
			this.Helo = val
			return true
		}
		'SMTPSecure' {
			this.SMTPSecure = val
			return true
		}
		'SMTPAutoTLS' {
			this.SMTPAutoTLS = val
			return true
		}
		'SMTPAuth' {
			this.SMTPAuth = val
			return true
		}
		'SMTPOptions' {
			this.SMTPOptions = val
			return true
		}
		'Username' {
			this.Username = val
			return true
		}
		'Password' {
			this.Password = val
			return true
		}
		'AuthType' {
			this.AuthType = val
			return true
		}
		'SMTPXClient' {
			this.SMTPXClient = val
			return true
		}
		'oauth' {
			this.oauth = val
			return true
		}
		'Timeout' {
			this.Timeout = val
			return true
		}
		'dsn' {
			this.dsn = val
			return true
		}
		'SMTPDebug' {
			this.SMTPDebug = val
			return true
		}
		'Debugoutput' {
			this.Debugoutput = val.str()
			return true
		}
		'SMTPKeepAlive' {
			this.SMTPKeepAlive = val
			return true
		}
		'SingleTo' {
			this.SingleTo = val
			return true
		}
		'SingleToArray' {
			this.SingleToArray = val
			return true
		}
		'do_verp' {
			this.do_verp = val
			return true
		}
		'AllowEmpty' {
			this.AllowEmpty = val
			return true
		}
		'DKIM_selector' {
			this.DKIM_selector = val
			return true
		}
		'DKIM_identity' {
			this.DKIM_identity = val
			return true
		}
		'DKIM_passphrase' {
			this.DKIM_passphrase = val
			return true
		}
		'DKIM_domain' {
			this.DKIM_domain = val
			return true
		}
		'DKIM_copyHeaderFields' {
			this.DKIM_copyHeaderFields = val
			return true
		}
		'DKIM_extraHeaders' {
			this.DKIM_extraHeaders = val
			return true
		}
		'DKIM_private' {
			this.DKIM_private = val
			return true
		}
		'DKIM_private_string' {
			this.DKIM_private_string = val
			return true
		}
		'action_function' {
			this.action_function = val
			return true
		}
		'XMailer' {
			this.XMailer = val
			return true
		}
		'smtp' {
			this.smtp = val
			return true
		}
		'to' {
			this.to = val
			return true
		}
		'cc' {
			this.cc = val
			return true
		}
		'bcc' {
			this.bcc = val
			return true
		}
		'ReplyTo' {
			this.ReplyTo = val
			return true
		}
		'all_recipients' {
			this.all_recipients = val
			return true
		}
		'RecipientsQueue' {
			this.RecipientsQueue = val
			return true
		}
		'ReplyToQueue' {
			this.ReplyToQueue = val
			return true
		}
		'UseSMTPUTF8' {
			this.UseSMTPUTF8 = val.to_bool()
			return true
		}
		'attachment' {
			this.attachment = val
			return true
		}
		'CustomHeader' {
			this.CustomHeader = val
			return true
		}
		'lastMessageID' {
			this.lastMessageID = val
			return true
		}
		'message_type' {
			this.message_type = val
			return true
		}
		'boundary' {
			this.boundary = val
			return true
		}
		'error_count' {
			this.error_count = val.to_i64()
			return true
		}
		'sign_cert_file' {
			this.sign_cert_file = val
			return true
		}
		'sign_key_file' {
			this.sign_key_file = val
			return true
		}
		'sign_extracerts_file' {
			this.sign_extracerts_file = val
			return true
		}
		'sign_key_pass' {
			this.sign_key_pass = val
			return true
		}
		'exceptions' {
			this.exceptions = val
			return true
		}
		'uniqueid' {
			this.uniqueid = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_PHPMailer_PHPMailer_SMTP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_PHPMailer_PHPMailer_SMTP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_PHPMailer_PHPMailer_SMTP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
