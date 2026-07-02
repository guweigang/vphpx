import rt

struct Class_WC_Email_Customer_Reset_Password {
	rt.PhpObjectBase
pub mut:
	user_id    rt.PhpVal = rt.new_null()
	user_login rt.PhpVal = rt.new_null()
	user_email rt.PhpVal = rt.new_null()
	reset_key  rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Reset_Password) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_reset_password'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Reset password'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Send an email to customers notifying them that their password has been reset'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-reset-password.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-reset-password.php'))
	this.dispatch_set_prop('email_group', rt.new_string('accounts'))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_reset_password_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Reset_Password', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.Class_WC_Email.construct()
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Account password reset'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when their password has been reset.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_default_subject() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [rt.new_string('Reset your password for {site_title}'),
			rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('Password Reset Request for {site_title}'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_default_heading() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [rt.new_string('Reset your password'),
			rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('Password Reset Request'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Customer_Reset_Password) trigger(user_login string, reset_key string) {
	this.setup_locale()
	if var_user_login.len > 0 && var_user_login != '0' && var_reset_key.len > 0
		&& var_reset_key != '0' {
		this.dispatch_set_prop('object', rt.call_function('get_user_by', [
			rt.new_string('login'),
			rt.new_string(user_login),
		]))
		this.user_id = rt.get_property(rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', [
			'WC_Email',
		], &this), 'object'), 'ID')
		this.user_login = rt.new_string(user_login)
		this.reset_key = rt.new_string(reset_key)
		this.user_email = rt.call_function('stripslashes', [
			rt.get_property(rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', [
				'WC_Email',
			], &this), 'object'), 'user_email'),
		])
		this.dispatch_set_prop('recipient', this.user_email)
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'user_id', val: this.user_id },
			rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'reset_key', val: this.reset_key },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Reset_Password', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'user_id', val: this.user_id },
			rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'reset_key', val: this.reset_key },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Reset_Password', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Reset_Password', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: this.user_id },
			rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'reset_key', val: this.reset_key },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Reset_Password', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Reset_Password) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Thanks for reading.'),
		rt.new_string('woocommerce')])
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

fn create_wc_email_customer_reset_password() &Class_WC_Email_Customer_Reset_Password {
	mut obj := &Class_WC_Email_Customer_Reset_Password{
		PhpObjectBase: rt.PhpObjectBase{}
		user_id:       rt.new_null()
		user_login:    rt.new_null()
		user_email:    rt.new_null()
		reset_key:     rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_email(_args ...rt.PhpVal) &Class_WC_Email {
	mut obj := &Class_WC_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_Reset_Password) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_default_subject' {
			return this.get_default_subject()
		}
		'get_default_heading' {
			return this.get_default_heading()
		}
		'trigger' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.trigger(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_content_html' {
			return this.get_content_html()
		}
		'get_content_plain' {
			return this.get_content_plain()
		}
		'get_block_editor_email_template_content' {
			return this.get_block_editor_email_template_content()
		}
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Reset_Password) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user_id' { return this.user_id }
		'user_login' { return this.user_login }
		'user_email' { return this.user_email }
		'reset_key' { return this.reset_key }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_Reset_Password) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user_id' {
			this.user_id = val
			return true
		}
		'user_login' {
			this.user_login = val
			return true
		}
		'user_email' {
			this.user_email = val
			return true
		}
		'reset_key' {
			this.reset_key = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Email) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Email) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Reset_Password'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_Reset_Password', ['WC_Email'],
		create_wc_email_customer_reset_password())
}
