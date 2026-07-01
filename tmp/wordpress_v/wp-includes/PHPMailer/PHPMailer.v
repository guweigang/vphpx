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
		Priority rt.PhpVal = rt.new_null()
		CharSet rt.PhpVal = rt.new_null()
		ContentType rt.PhpVal = rt.new_null()
		Encoding rt.PhpVal = rt.new_null()
		ErrorInfo rt.PhpVal = rt.new_string('')
		From rt.PhpVal = rt.new_string('')
		FromName rt.PhpVal = rt.new_string('')
		Sender rt.PhpVal = rt.new_string('')
		Subject string
		Body rt.PhpVal = rt.new_string('')
		AltBody rt.PhpVal = rt.new_string('')
		Ical rt.PhpVal = rt.new_string('')
		IcalMethods rt.PhpVal = rt.new_array()
		MIMEBody rt.PhpVal = rt.new_string('')
		MIMEHeader rt.PhpVal = rt.new_string('')
		mailHeader string
		WordWrap rt.PhpVal = rt.new_int(0)
		Mailer string
		Sendmail rt.PhpVal = rt.new_string('/usr/sbin/sendmail')
		UseSendmailOptions rt.PhpVal = rt.new_bool(true)
		ConfirmReadingTo rt.PhpVal = rt.new_string('')
		Hostname rt.PhpVal = rt.new_string('')
		MessageID rt.PhpVal = rt.new_string('')
		MessageDate rt.PhpVal = rt.new_string('')
		Host string
		Port rt.PhpVal = rt.new_int(25)
		Helo rt.PhpVal = rt.new_string('')
		SMTPSecure rt.PhpVal = rt.new_string('')
		SMTPAutoTLS rt.PhpVal = rt.new_bool(true)
		SMTPAuth rt.PhpVal = rt.new_bool(false)
		SMTPOptions rt.PhpVal = rt.new_array()
		Username rt.PhpVal = rt.new_string('')
		Password rt.PhpVal = rt.new_string('')
		AuthType rt.PhpVal = rt.new_string('')
		SMTPXClient rt.PhpVal = rt.new_array()
		oauth rt.PhpVal = rt.new_null()
		Timeout rt.PhpVal = rt.new_int(300)
		dsn rt.PhpVal = rt.new_string('')
		SMTPDebug rt.PhpVal = rt.new_int(0)
		Debugoutput string
		SMTPKeepAlive rt.PhpVal = rt.new_bool(false)
		SingleTo rt.PhpVal = rt.new_bool(false)
		SingleToArray rt.PhpVal = rt.new_array()
		do_verp rt.PhpVal = rt.new_bool(false)
		AllowEmpty rt.PhpVal = rt.new_bool(false)
		DKIM_selector rt.PhpVal = rt.new_string('')
		DKIM_identity rt.PhpVal = rt.new_string('')
		DKIM_passphrase rt.PhpVal = rt.new_string('')
		DKIM_domain rt.PhpVal = rt.new_string('')
		DKIM_copyHeaderFields rt.PhpVal = rt.new_bool(true)
		DKIM_extraHeaders rt.PhpVal = rt.new_array()
		DKIM_private rt.PhpVal = rt.new_string('')
		DKIM_private_string rt.PhpVal = rt.new_string('')
		action_function rt.PhpVal = rt.new_string('')
		XMailer rt.PhpVal = rt.new_string('')
		validator rt.PhpVal = rt.new_string('php')
		smtp rt.PhpVal = rt.new_null()
		to rt.PhpVal = rt.new_array()
		cc rt.PhpVal = rt.new_array()
		bcc rt.PhpVal = rt.new_array()
		ReplyTo rt.PhpVal = rt.new_array()
		all_recipients rt.PhpVal = rt.new_array()
		RecipientsQueue rt.PhpVal = rt.new_array()
		ReplyToQueue rt.PhpVal = rt.new_array()
		UseSMTPUTF8 bool
		attachment rt.PhpVal = rt.new_array()
		CustomHeader rt.PhpVal = rt.new_array()
		lastMessageID rt.PhpVal = rt.new_string('')
		message_type rt.PhpVal = rt.new_string('')
		boundary rt.PhpVal = rt.new_array()
		language rt.PhpVal = rt.new_array()
		error_count i64
		sign_cert_file rt.PhpVal = rt.new_string('')
		sign_key_file rt.PhpVal = rt.new_string('')
		sign_extracerts_file rt.PhpVal = rt.new_string('')
		sign_key_pass rt.PhpVal = rt.new_string('')
		exceptions rt.PhpVal = rt.new_bool(false)
		uniqueid rt.PhpVal = rt.new_string('')
		LE rt.PhpVal = rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) construct(var_exceptions rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		this.exceptions = // unsupported expression: Expr_Cast_Bool
	}
	this.Debugoutput = if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { 'echo' } else { 'html' }
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) magic_destruct()  {
	this.smtpclose()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) mailpassthru(var_to rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal, var_header rt.PhpVal, var_params rt.PhpVal) rt.PhpVal {
	mut var_to_mutated := var_to
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
	mut var_header_mutated := var_header
	mut var_params_mutated := var_params
	if rt.is_true(rt.bitwise_and(// unsupported expression: Expr_Cast_Int, rt.new_int(1))) {
		var_subject_mutated = rt.new_string(this.secureheader(var_subject_mutated.dup()))
	} else {
		var_subject_mutated = rt.new_string(this.encodeheader(rt.new_string(this.secureheader(var_subject_mutated.dup())), ''))
	}
	this.edebug(rt.new_string('Sending with mail()'))
	this.edebug(rt.new_string('Sendmail path: ' + (rt.call_function('ini_get', [rt.new_string('sendmail_path')])).str()))
	this.edebug(rt.new_string(rt.concat(rt.new_string('Envelope sender: '), this.Sender)))
	this.edebug(rt.new_string("To: ${var_to.to_string()}"))
	this.edebug(rt.new_string("Subject: ${var_subject.to_string()}"))
	this.edebug(rt.new_string("Headers: ${var_header.to_string()}"))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(this.UseSendmailOptions)))) || rt.is_true(rt.identical(rt.new_null(), var_params_mutated)))) {
		mut var_result := rt.call_function('mail', [var_to_mutated.dup(), var_subject_mutated.dup(), var_body_mutated.dup(), var_header_mutated.dup()])
	} else {
		this.edebug(rt.new_string("Additional params: ${var_params.to_string()}"))
		var_result = rt.call_function('mail', [var_to_mutated.dup(), var_subject_mutated.dup(), var_body_mutated.dup(), var_header_mutated.dup(), var_params_mutated.dup()])
	}
	this.edebug(rt.new_string('Result: ' + if rt.is_true(var_result) { 'true' } else { 'false' }))
	return var_result.dup()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) edebug(var_str rt.PhpVal)  {
	mut var_str_mutated := var_str
	if rt.is_true(rt.less_equal(this.SMTPDebug, rt.new_int(0))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.instance_of(this.Debugoutput, 'PHPMailer_PHPMailer_Psr_Log_LoggerInterface'))) {
		rt.call_method(this.Debugoutput, 'debug', [rt.new_string(var_str_mutated.dup().to_string().trim_right(' \t\n\r'))])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_callable', [this.Debugoutput])) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.Debugoutput, rt.create_array([rt.ArrayItem{ key: none, val: 'error_log' }, rt.ArrayItem{ key: none, val: 'html' }, rt.ArrayItem{ key: none, val: 'echo' }])]))))))) {
		rt.call_function('call_user_func', [this.Debugoutput, var_str_mutated.dup(), this.SMTPDebug])
		return rt.new_null()
	}
	mut switch_val_1 := this.Debugoutput
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('error_log'))) {
		rt.call_function('error_log', [var_str_mutated.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) {
		rt.echo_val(rt.call_function('htmlentities', [rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'), rt.new_string(''), var_str_mutated.dup()]), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')]))
		print('<br>\n')
	} else {
		var_str_mutated = rt.call_function('preg_replace', [rt.new_string('/\\r\\n|\\r/m'), rt.new_string('\n'), var_str_mutated.dup()])
		rt.echo_val(rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]))
		print('\t')
		print(rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\n                   \t                  '), rt.new_string(var_str_mutated.dup().to_string().trim_space())]).to_string().trim_space())
		print('\n')
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) ishtml(isHtml bool)  {
	if var_isHtml {
		this.ContentType = Class_PHPMailer_PHPMailer_static.content_type_text_html()
	} else {
		this.ContentType = Class_PHPMailer_PHPMailer_static.content_type_plaintext()
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) issmtp()  {
	this.Mailer = 'smtp'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) ismail()  {
	this.Mailer = 'mail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) parsesendmailpath(var_sendmailPath rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_sendmailPath_mutated := var_sendmailPath
	var_sendmailPath_mutated = rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().trim_space()))
	if rt.is_true(rt.identical(var_sendmailPath_mutated, rt.new_string(''))) {
		return var_sendmailPath_mutated.dup()
	}
	mut var_parts := rt.call_function('preg_split', [rt.new_string('/\\s+/'), var_sendmailPath_mutated.dup()])
	if !rt.is_true(var_parts) {
		return var_sendmailPath_mutated.dup()
	}
	mut var_command := rt.call_function('array_shift', [var_parts.dup()])
	mut var_remainder := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(var_parts.dup().array_count())))) { break }
			mut var_part := var_parts.array_get(var_i)
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^-(i|oi|t)$/'), var_part.dup(), var_matches.dup()])) {
				continue
			}
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^-f(.*)$/'), var_part.dup(), var_matches.dup()])) {
				mut var_address := var_matches.array_get(1)
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_address, rt.new_string(''))) && var_parts.array_isset(rt.add(var_i, rt.new_int(1))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_address = var_parts.array_get(rt.pre_inc(var_i))
				}
				this.Sender = var_address.dup()
				continue
			}
			var_remainder.array_push(var_part.dup())
			rt.pre_inc(var_i)
		}
	}
	if !(!rt.is_true(var_remainder)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_command.dup()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) issendmail()  {
	mut var_ini_sendmail_path := rt.call_function('ini_get', [rt.new_string('sendmail_path')])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_ini_sendmail_path.dup(), rt.new_string('sendmail')]))) {
		var_ini_sendmail_path = rt.new_string(rt.new_string('/usr/sbin/sendmail'))
	}
	this.Sendmail = this.parsesendmailpath(var_ini_sendmail_path.dup())
	this.Mailer = 'sendmail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) isqmail()  {
	mut var_ini_sendmail_path := rt.call_function('ini_get', [rt.new_string('sendmail_path')])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('stripos', [var_ini_sendmail_path.dup(), rt.new_string('qmail')]))) {
		var_ini_sendmail_path = rt.new_string(rt.new_string('/var/qmail/bin/qmail-inject'))
	}
	this.Sendmail = this.parsesendmailpath(var_ini_sendmail_path.dup())
	this.Mailer = 'qmail'
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addaddress(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('to'), var_address_mutated.dup(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addcc(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('cc'), var_address_mutated.dup(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addbcc(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('bcc'), var_address_mutated.dup(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addreplyto(var_address rt.PhpVal, name string) rt.PhpVal {
	mut var_address_mutated := var_address
	mut name_mutated := name
	return rt.new_bool(this.addorenqueueanaddress(rt.new_string('Reply-To'), var_address_mutated.dup(), rt.new_string(name_mutated)))
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addorenqueueanaddress(var_kind rt.PhpVal, var_address rt.PhpVal, var_name rt.PhpVal) bool {
	mut var_address_mutated := var_address
	mut var_name_mutated := var_name
	mut var_pos := rt.new_bool(rt.new_bool(false))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_address_mutated = rt.new_string(rt.new_string(var_address_mutated.dup().to_string().trim_space()))
		var_pos = rt.call_function('strrpos', [var_address_mutated.dup(), rt.new_string('@')])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_pos)) {
		mut var_error_message := rt.call_function('sprintf', [rt.new_string('%s (%s): %s'), Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')), var_kind.dup(), var_address_mutated.dup()])
		this.seterror(var_error_message.dup())
		this.edebug(var_error_message.dup())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(var_error_message.dup())))
		}
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(var_name_mutated.dup().is_string())))) {
		var_name_mutated = rt.new_string(rt.new_string(rt.call_function('preg_replace', [rt.new_string('/[\\r\\n]+/'), rt.new_string(''), var_name_mutated.dup()]).to_string().trim_space()))
		// unsupported statement: Stmt_Nop
	} else {
		var_name_mutated = rt.new_string(rt.new_string(''))
	}
	mut var_params := rt.create_array([rt.ArrayItem{ key: none, val: var_kind }, rt.ArrayItem{ key: none, val: var_address_mutated }, rt.ArrayItem{ key: none, val: var_name_mutated }])
	if rt.is_true(this.has8bitchars(rt.call_function('substr', [var_address_mutated.dup(), rt.pre_inc(var_pos)]))) {
		if rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.idnsupported()) {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.RecipientsQueue.array_isset(var_address_mutated.dup())))))) {
					this.RecipientsQueue.array_set(var_address_mutated, var_params.dup())
					return true
				}
			} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.ReplyToQueue.array_isset(var_address_mutated.dup())))))) {
				this.ReplyToQueue.array_set(var_address_mutated, var_params.dup())
				return true
			}
		}
		return false
	}
	return (rt.call_function('call_user_func_array', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'addAnAddress' }]), var_params.dup()])).to_bool()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setboundaries()  {
	this.uniqueid = this.generateid()
	this.boundary.array_set(1, 'b1=_' + (this.uniqueid).str())
	this.boundary.array_set(2, 'b2=_' + (this.uniqueid).str())
	this.boundary.array_set(3, 'b3=_' + (this.uniqueid).str())
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addanaddress(var_kind rt.PhpVal, var_address rt.PhpVal, name string) bool {
	mut var_address_mutated := var_address
	mut name_mutated := name
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_StaticPropertyFetch, rt.new_string('php'))) && rt.is_true(// unsupported expression: Expr_Cast_Bool))) {
		this.CharSet = Class_PHPMailer_PHPMailer_PHPMailer_PHPMailer_PHPMailer.charset_utf8()
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_kind.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'to' }, rt.ArrayItem{ key: none, val: 'cc' }, rt.ArrayItem{ key: none, val: 'bcc' }, rt.ArrayItem{ key: none, val: 'Reply-To' }])]))))) {
		mut var_error_message := rt.call_function('sprintf', [rt.new_string('%s: %s'), Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('Invalid recipient kind')), var_kind.dup()])
		this.seterror(var_error_message.dup())
		this.edebug(var_error_message.dup())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(var_error_message.dup())))
		}
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address_mutated.dup()))))) {
		var_error_message = rt.call_function('sprintf', [rt.new_string('%s (%s): %s'), Class_PHPMailer_PHPMailer_PHPMailer.lang(rt.new_string('invalid_address')), var_kind.dup(), var_address_mutated.dup()])
		this.seterror(var_error_message.dup())
		this.edebug(var_error_message.dup())
		if rt.is_true(this.exceptions) {
			rt.throw_exception(rt.new_object('PHPMailer_PHPMailer_Exception', []string{}, create_phpmailer_phpmailer_exception(var_error_message.dup())))
		}
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.all_recipients.array_isset(rt.new_string(var_address_mutated.dup().to_string().to_lower()))))))) {
			rt.get_property(rt.new_object('PHPMailer_PHPMailer_PHPMailer', []string{}, &this), '{"nodeType":"Expr_Variable","line":1265,"name":"kind"}').array_push(rt.create_array([rt.ArrayItem{ key: none, val: var_address_mutated }, rt.ArrayItem{ key: none, val: name_mutated }]))
			this.all_recipients.array_set(.dup().to_string().to_lower(), true)
			return true
		}
	} else {
		{
			mut iter_1 := this.ReplyTo.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_replyTo := item_1.val
				if rt.is_true() {
				}
			}
		}
		
	}
	return 
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(var_addrstr rt.PhpVal, var_useimap rt.PhpVal, var_charset rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parsesimpleraddresses(var_addrstr rt.PhpVal, var_charset rt.PhpVal) rt.PhpVal {
	mut var_charset_mutated := var_charset
}

fn Class_PHPMailer_PHPMailer_PHPMailer.parseemailstring(var_input rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_input_mutated := var_input
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setfrom(var_address rt.PhpVal, name string, auto bool) bool {
	mut var_address_mutated := var_address
	mut name_mutated := name
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getlastmessageid() rt.PhpVal {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(var_address rt.PhpVal, var_patternselect rt.PhpVal) bool {
	mut var_address_mutated := var_address
	mut var_patternselect_mutated := var_patternselect
	return false
}

fn Class_PHPMailer_PHPMailer_PHPMailer.idnsupported() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) punyencodeaddress(var_address rt.PhpVal) string {
	mut var_address_mutated := var_address
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) send() bool {
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) presend() bool {
	return false
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) postsend() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) sendmailsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
}

fn Class_PHPMailer_PHPMailer_PHPMailer.isshellsafe(var_string rt.PhpVal) bool {
	mut var_string_mutated := var_string
}

fn Class_PHPMailer_PHPMailer_PHPMailer.ispermittedpath(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
}

fn Class_PHPMailer_PHPMailer_PHPMailer.fileisaccessible(var_path rt.PhpVal) bool {
	mut var_path_mutated := var_path
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) mailsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtpinstance() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setsmtpinstance(mut var_smtp Class_PHPMailer_PHPMailer_SMTP) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setsmtpxclientattribute(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtpxclientattributes() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpsend(var_header rt.PhpVal, var_body rt.PhpVal) bool {
	mut var_header_mutated := var_header
	mut var_body_mutated := var_body
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpconnect(var_options rt.PhpVal) bool {
	mut var_options_mutated := var_options
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) smtpclose()  {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.setlanguage(langcode string, lang_path string) rt.PhpVal {
	mut langcode_mutated := langcode
	mut lang_path_mutated := lang_path
	return rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) gettranslations() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addrappend(var_type rt.PhpVal, var_addr rt.PhpVal) string {
	mut var_type_mutated := var_type
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addrformat(var_addr rt.PhpVal) string {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) wraptext(var_message rt.PhpVal, var_length rt.PhpVal, qp_mode bool) rt.PhpVal {
	mut var_message_mutated := var_message
	mut var_length_mutated := var_length
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) utf8charboundary(var_encodedText rt.PhpVal, var_maxLength rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setwordwrap()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) createheader() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getmailmime() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsentmimemessage() string {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) generateid() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) createbody() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getboundaries() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getboundary(var_boundary rt.PhpVal, var_charSet rt.PhpVal, var_contentType rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	mut var_charSet_mutated := var_charSet
	mut var_contentType_mutated := var_contentType
	mut var_encoding_mutated := var_encoding
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) endboundary(var_boundary rt.PhpVal) string {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setmessagetype()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) headerline(var_name rt.PhpVal, var_value rt.PhpVal) string {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) textline(var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addattachment(var_path rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_path_mutated := var_path
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getattachments() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) attachall(var_disposition_type rt.PhpVal, var_boundary rt.PhpVal) string {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodefile(var_path rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	mut var_path_mutated := var_path
	mut var_encoding_mutated := var_encoding
	return rt.new_null()
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodestring(var_str rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
	mut var_encoding_mutated := var_encoding
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeheader(var_str rt.PhpVal, position string) string {
	mut var_matches := rt.new_null()
	mut var_str_mutated := var_str
	mut position_mutated := position
}

fn Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(var_value rt.PhpVal, var_charset rt.PhpVal) string {
	mut var_value_mutated := var_value
	mut var_charset_mutated := var_charset
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) hasmultibytes(var_str rt.PhpVal) bool {
	mut var_str_mutated := var_str
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) has8bitchars(var_text rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) base64encodewrapmb(var_str rt.PhpVal, var_linebreak rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
	mut var_linebreak_mutated := var_linebreak
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeqp(var_string rt.PhpVal) rt.PhpVal {
	mut var_string_mutated := var_string
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) encodeq(var_str rt.PhpVal, position string) rt.PhpVal {
	mut var_str_mutated := var_str
	mut position_mutated := position
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addstringattachment(var_string rt.PhpVal, var_filename rt.PhpVal, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_string_mutated := var_string
	mut var_filename_mutated := var_filename
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addembeddedimage(var_path rt.PhpVal, var_cid rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_path_mutated := var_path
	mut var_cid_mutated := var_cid
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addstringembeddedimage(var_string rt.PhpVal, var_cid rt.PhpVal, name string, var_encoding rt.PhpVal, type string, disposition string) bool {
	mut var_string_mutated := var_string
	mut var_cid_mutated := var_cid
	mut name_mutated := name
	mut var_encoding_mutated := var_encoding
	mut type_mutated := type
	mut disposition_mutated := disposition
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) validateencoding(var_encoding rt.PhpVal) rt.PhpVal {
	mut var_encoding_mutated := var_encoding
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) cidexists(var_cid rt.PhpVal) bool {
	mut var_cid_mutated := var_cid
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) inlineimageexists() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) attachmentexists() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) alternativeexists() bool {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearqueuedaddresses(var_kind rt.PhpVal)  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearaddresses()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearccs()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearbccs()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearreplytos()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearallrecipients()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearattachments()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearcustomheaders()  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) clearcustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) replacecustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) seterror(var_msg rt.PhpVal)  {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.rfcdate() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) serverhostname() string {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.isvalidhost(var_host rt.PhpVal) bool {
	mut var_host_mutated := var_host
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addresshasunicodelocalpart(var_address rt.PhpVal) rt.PhpVal {
	mut var_address_mutated := var_address
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) anyaddresshasunicodelocalpart(var_addresses rt.PhpVal) bool {
	mut var_addresses_mutated := var_addresses
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) needssmtputf8() bool {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.lang(var_key rt.PhpVal) string {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getsmtperrormessage(var_base_key rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) iserror() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) addcustomheader(var_name rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_name_mutated := var_name
	mut var_value_mutated := var_value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getcustomheaders() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) msghtml(var_message rt.PhpVal, basedir string, advanced bool) rt.PhpVal {
	mut var_images := rt.new_null()
	mut var_message_mutated := var_message
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) html2text(var_html rt.PhpVal, advanced bool) rt.PhpVal {
}

fn Class_PHPMailer_PHPMailer_PHPMailer._mime_types(ext string) string {
	mut ext_mutated := ext
}

fn Class_PHPMailer_PHPMailer_PHPMailer.filenametotype(var_filename rt.PhpVal) rt.PhpVal {
	mut var_filename_mutated := var_filename
}

fn Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(var_path rt.PhpVal, var_options rt.PhpVal)  {
	mut var_path_mutated := var_path
	mut var_options_mutated := var_options
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) set(var_name rt.PhpVal, value string) bool {
	mut var_name_mutated := var_name
	mut value_mutated := value
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) secureheader(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
}

fn Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(var_text rt.PhpVal, var_breaktype rt.PhpVal) rt.PhpVal {
	mut var_text_mutated := var_text
	mut var_breaktype_mutated := var_breaktype
}

fn Class_PHPMailer_PHPMailer_PHPMailer.striptrailingwsp(var_text rt.PhpVal) string {
	mut var_text_mutated := var_text
}

fn Class_PHPMailer_PHPMailer_PHPMailer.striptrailingbreaks(var_text rt.PhpVal) string {
	mut var_text_mutated := var_text
}

fn Class_PHPMailer_PHPMailer_PHPMailer.getle() rt.PhpVal {
}

fn Class_PHPMailer_PHPMailer_PHPMailer.setle(var_le rt.PhpVal)  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) sign(var_cert_filename rt.PhpVal, var_key_filename rt.PhpVal, var_key_pass rt.PhpVal, extracerts_filename string)  {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_qp(var_txt rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_sign(var_signHeader rt.PhpVal) string {
	mut var_signature := rt.new_null()
	mut var_signHeader_mutated := var_signHeader
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_headerc(var_signHeader rt.PhpVal) rt.PhpVal {
	mut var_signHeader_mutated := var_signHeader
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_bodyc(var_body rt.PhpVal) string {
	mut var_body_mutated := var_body
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dkim_add(var_headers_line rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal) rt.PhpVal {
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
}

fn Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(var_str rt.PhpVal) rt.PhpVal {
	mut var_str_mutated := var_str
}

fn Class_PHPMailer_PHPMailer_PHPMailer.quotedstring(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) gettoaddresses() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getccaddresses() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getbccaddresses() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getreplytoaddresses() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getallrecipientaddresses() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) docallback(var_isSent rt.PhpVal, var_to rt.PhpVal, var_cc rt.PhpVal, var_bcc rt.PhpVal, var_subject rt.PhpVal, var_body rt.PhpVal, var_from rt.PhpVal, var_extra rt.PhpVal)  {
	mut var_isSent_mutated := var_isSent
	mut var_to_mutated := var_to
	mut var_subject_mutated := var_subject
	mut var_body_mutated := var_body
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) getoauth() rt.PhpVal {
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) setoauth(mut var_oauth Class_PHPMailer_PHPMailer_OAuthTokenProvider)  {
}

struct Class_PHPMailer_PHPMailer_Exception {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_phpmailer(arg_0 rt.PhpVal) &Class_PHPMailer_PHPMailer_PHPMailer {
	mut obj := &Class_PHPMailer_PHPMailer_PHPMailer{
		PhpObjectBase: rt.PhpObjectBase{}
		Priority: rt.new_null()
		CharSet: rt.new_null()
		ContentType: rt.new_null()
		Encoding: rt.new_null()
		ErrorInfo: rt.new_string('')
		From: rt.new_string('')
		FromName: rt.new_string('')
		Sender: rt.new_string('')
		Subject: ''
		Body: rt.new_string('')
		AltBody: rt.new_string('')
		Ical: rt.new_string('')
		IcalMethods: rt.new_array()
		MIMEBody: rt.new_string('')
		MIMEHeader: rt.new_string('')
		mailHeader: ''
		WordWrap: rt.new_int(0)
		Mailer: ''
		Sendmail: rt.new_string('/usr/sbin/sendmail')
		UseSendmailOptions: rt.new_bool(true)
		ConfirmReadingTo: rt.new_string('')
		Hostname: rt.new_string('')
		MessageID: rt.new_string('')
		MessageDate: rt.new_string('')
		Host: ''
		Port: rt.new_int(25)
		Helo: rt.new_string('')
		SMTPSecure: rt.new_string('')
		SMTPAutoTLS: rt.new_bool(true)
		SMTPAuth: rt.new_bool(false)
		SMTPOptions: rt.new_array()
		Username: rt.new_string('')
		Password: rt.new_string('')
		AuthType: rt.new_string('')
		SMTPXClient: rt.new_array()
		oauth: rt.new_null()
		Timeout: rt.new_int(300)
		dsn: rt.new_string('')
		SMTPDebug: rt.new_int(0)
		Debugoutput: ''
		SMTPKeepAlive: rt.new_bool(false)
		SingleTo: rt.new_bool(false)
		SingleToArray: rt.new_array()
		do_verp: rt.new_bool(false)
		AllowEmpty: rt.new_bool(false)
		DKIM_selector: rt.new_string('')
		DKIM_identity: rt.new_string('')
		DKIM_passphrase: rt.new_string('')
		DKIM_domain: rt.new_string('')
		DKIM_copyHeaderFields: rt.new_bool(true)
		DKIM_extraHeaders: rt.new_array()
		DKIM_private: rt.new_string('')
		DKIM_private_string: rt.new_string('')
		action_function: rt.new_string('')
		XMailer: rt.new_string('')
		validator: rt.new_string('php')
		smtp: rt.new_null()
		to: rt.new_array()
		cc: rt.new_array()
		bcc: rt.new_array()
		ReplyTo: rt.new_array()
		all_recipients: rt.new_array()
		RecipientsQueue: rt.new_array()
		ReplyToQueue: rt.new_array()
		UseSMTPUTF8: false
		attachment: rt.new_array()
		CustomHeader: rt.new_array()
		lastMessageID: rt.new_string('')
		message_type: rt.new_string('')
		boundary: rt.new_array()
		language: rt.new_array()
		error_count: i64(0)
		sign_cert_file: rt.new_string('')
		sign_key_file: rt.new_string('')
		sign_extracerts_file: rt.new_string('')
		sign_key_pass: rt.new_string('')
		exceptions: rt.new_bool(false)
		uniqueid: rt.new_string('')
		LE: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_phpmailer_phpmailer_exception() &Class_PHPMailer_PHPMailer_Exception {
	mut obj := &Class_PHPMailer_PHPMailer_Exception{
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
			return this.mailpassthru(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
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
			return rt.new_bool(this.addorenqueueanaddress(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
			return Class_PHPMailer_PHPMailer_PHPMailer.parseaddresses(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'parseSimplerAddresses' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_PHPMailer_PHPMailer_PHPMailer.parsesimpleraddresses(dispatch_arg_0, dispatch_arg_1)
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
			return rt.new_bool(Class_PHPMailer_PHPMailer_PHPMailer.validateaddress(dispatch_arg_0, dispatch_arg_1))
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_SMTP](if args.len > 0 { args[0] } else { rt.new_null() })
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
			return rt.new_bool(this.addattachment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
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
			return this.encodefile(dispatch_arg_0, dispatch_arg_1)
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
			return rt.new_string(Class_PHPMailer_PHPMailer_PHPMailer.decodeheader(dispatch_arg_0, dispatch_arg_1))
		}
		'hasMultiBytes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hasmultibytes(dispatch_arg_0))
		}
		'has8bitChars' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has8bitchars(dispatch_arg_0)
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
			return rt.new_bool(this.addstringattachment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'addEmbeddedImage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this.addembeddedimage(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
		}
		'addStringEmbeddedImage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			return rt.new_bool(this.addstringembeddedimage(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5))
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
			return this.addresshasunicodelocalpart(dispatch_arg_0)
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
			Class_PHPMailer_PHPMailer_PHPMailer.mb_pathinfo(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
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
			return Class_PHPMailer_PHPMailer_PHPMailer.normalizebreaks(dispatch_arg_0, dispatch_arg_1)
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
			return Class_PHPMailer_PHPMailer_PHPMailer.haslinelongerthanmax(dispatch_arg_0)
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
			this.docallback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5, dispatch_arg_6, dispatch_arg_7)
			return rt.new_null()
		}
		'getOAuth' {
			return this.getoauth()
		}
		'setOAuth' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_PHPMailer_PHPMailer_OAuthTokenProvider](if args.len > 0 { args[0] } else { rt.new_null() })
			this.setoauth(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
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
		'IcalMethods' { return this.IcalMethods }
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
		'validator' { return this.validator }
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
		'language' { return this.language }
		'error_count' { return rt.new_int(this.error_count) }
		'sign_cert_file' { return this.sign_cert_file }
		'sign_key_file' { return this.sign_key_file }
		'sign_extracerts_file' { return this.sign_extracerts_file }
		'sign_key_pass' { return this.sign_key_pass }
		'exceptions' { return this.exceptions }
		'uniqueid' { return this.uniqueid }
		'LE' { return this.LE }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PHPMailer_PHPMailer_PHPMailer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'Priority' { this.Priority = val; return true }
		'CharSet' { this.CharSet = val; return true }
		'ContentType' { this.ContentType = val; return true }
		'Encoding' { this.Encoding = val; return true }
		'ErrorInfo' { this.ErrorInfo = val; return true }
		'From' { this.From = val; return true }
		'FromName' { this.FromName = val; return true }
		'Sender' { this.Sender = val; return true }
		'Subject' { this.Subject = (val).str(); return true }
		'Body' { this.Body = val; return true }
		'AltBody' { this.AltBody = val; return true }
		'Ical' { this.Ical = val; return true }
		'IcalMethods' { this.IcalMethods = val; return true }
		'MIMEBody' { this.MIMEBody = val; return true }
		'MIMEHeader' { this.MIMEHeader = val; return true }
		'mailHeader' { this.mailHeader = (val).str(); return true }
		'WordWrap' { this.WordWrap = val; return true }
		'Mailer' { this.Mailer = (val).str(); return true }
		'Sendmail' { this.Sendmail = val; return true }
		'UseSendmailOptions' { this.UseSendmailOptions = val; return true }
		'ConfirmReadingTo' { this.ConfirmReadingTo = val; return true }
		'Hostname' { this.Hostname = val; return true }
		'MessageID' { this.MessageID = val; return true }
		'MessageDate' { this.MessageDate = val; return true }
		'Host' { this.Host = (val).str(); return true }
		'Port' { this.Port = val; return true }
		'Helo' { this.Helo = val; return true }
		'SMTPSecure' { this.SMTPSecure = val; return true }
		'SMTPAutoTLS' { this.SMTPAutoTLS = val; return true }
		'SMTPAuth' { this.SMTPAuth = val; return true }
		'SMTPOptions' { this.SMTPOptions = val; return true }
		'Username' { this.Username = val; return true }
		'Password' { this.Password = val; return true }
		'AuthType' { this.AuthType = val; return true }
		'SMTPXClient' { this.SMTPXClient = val; return true }
		'oauth' { this.oauth = val; return true }
		'Timeout' { this.Timeout = val; return true }
		'dsn' { this.dsn = val; return true }
		'SMTPDebug' { this.SMTPDebug = val; return true }
		'Debugoutput' { this.Debugoutput = (val).str(); return true }
		'SMTPKeepAlive' { this.SMTPKeepAlive = val; return true }
		'SingleTo' { this.SingleTo = val; return true }
		'SingleToArray' { this.SingleToArray = val; return true }
		'do_verp' { this.do_verp = val; return true }
		'AllowEmpty' { this.AllowEmpty = val; return true }
		'DKIM_selector' { this.DKIM_selector = val; return true }
		'DKIM_identity' { this.DKIM_identity = val; return true }
		'DKIM_passphrase' { this.DKIM_passphrase = val; return true }
		'DKIM_domain' { this.DKIM_domain = val; return true }
		'DKIM_copyHeaderFields' { this.DKIM_copyHeaderFields = val; return true }
		'DKIM_extraHeaders' { this.DKIM_extraHeaders = val; return true }
		'DKIM_private' { this.DKIM_private = val; return true }
		'DKIM_private_string' { this.DKIM_private_string = val; return true }
		'action_function' { this.action_function = val; return true }
		'XMailer' { this.XMailer = val; return true }
		'validator' { this.validator = val; return true }
		'smtp' { this.smtp = val; return true }
		'to' { this.to = val; return true }
		'cc' { this.cc = val; return true }
		'bcc' { this.bcc = val; return true }
		'ReplyTo' { this.ReplyTo = val; return true }
		'all_recipients' { this.all_recipients = val; return true }
		'RecipientsQueue' { this.RecipientsQueue = val; return true }
		'ReplyToQueue' { this.ReplyToQueue = val; return true }
		'UseSMTPUTF8' { this.UseSMTPUTF8 = (val).to_bool(); return true }
		'attachment' { this.attachment = val; return true }
		'CustomHeader' { this.CustomHeader = val; return true }
		'lastMessageID' { this.lastMessageID = val; return true }
		'message_type' { this.message_type = val; return true }
		'boundary' { this.boundary = val; return true }
		'language' { this.language = val; return true }
		'error_count' { this.error_count = (val).to_i64(); return true }
		'sign_cert_file' { this.sign_cert_file = val; return true }
		'sign_key_file' { this.sign_key_file = val; return true }
		'sign_extracerts_file' { this.sign_extracerts_file = val; return true }
		'sign_key_pass' { this.sign_key_pass = val; return true }
		'exceptions' { this.exceptions = val; return true }
		'uniqueid' { this.uniqueid = val; return true }
		'LE' { this.LE = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_phpmailer_phpmailer_php() {
}
