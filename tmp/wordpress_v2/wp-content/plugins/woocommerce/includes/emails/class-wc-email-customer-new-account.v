import rt

struct Class_WC_Email_Customer_New_Account {
	rt.PhpObjectBase
pub mut:
	user_login         rt.PhpVal = rt.new_null()
	user_email         rt.PhpVal = rt.new_null()
	user_pass          rt.PhpVal = rt.new_null()
	password_generated rt.PhpVal = rt.new_null()
	set_password_url   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Email_Customer_New_Account) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_new_account'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [rt.new_string('New account'),
		rt.new_string('woocommerce')]))
	this.dispatch_set_prop('email_group', rt.new_string('accounts'))
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Send an email to customers notifying them that they have created an account'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-new-account.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/customer-new-account.php'))
	this.Class_WC_Email.construct()
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_New_Account', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Account created'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when their account has been created.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_New_Account) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Your {site_title} account has been created!'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_New_Account) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Welcome to {site_title}'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_New_Account) trigger(var_user_id rt.PhpVal, user_pass string, password_generated bool) {
	this.setup_locale()
	if rt.is_true(var_user_id) {
		this.dispatch_set_prop('object', create_wp_user(var_user_id.clone()))
		this.set_password_url = this.generate_set_password_url()
		this.user_login = rt.call_function('stripslashes', [
			rt.get_property(rt.get_property(rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this), 'object'), 'user_login'),
		])
		this.user_email = rt.call_function('stripslashes', [
			rt.get_property(rt.get_property(rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this), 'object'), 'user_email'),
		])
		this.dispatch_set_prop('recipient', this.user_email)
		this.user_pass = rt.new_string(user_pass)
		this.password_generated = rt.new_bool(password_generated)
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_New_Account) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_New_Account', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'set_password_url', val: this.set_password_url },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this) }, rt.ArrayItem{ key: 'password_generated', val: this.password_generated },
			rt.ArrayItem{ key: 'user_pass', val: this.user_pass }]),
	])
}

fn (mut this Class_WC_Email_Customer_New_Account) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_New_Account', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'set_password_url', val: this.set_password_url },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this) }, rt.ArrayItem{ key: 'password_generated', val: this.password_generated },
			rt.ArrayItem{ key: 'user_pass', val: this.user_pass }]),
	])
}

fn (mut this Class_WC_Email_Customer_New_Account) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_New_Account', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'user_login', val: this.user_login },
			rt.ArrayItem{ key: 'set_password_url', val: this.set_password_url },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this) }, rt.ArrayItem{ key: 'password_generated', val: this.password_generated },
			rt.ArrayItem{ key: 'user_pass', val: this.user_pass }]),
	])
}

fn (mut this Class_WC_Email_Customer_New_Account) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('We look forward to seeing you soon.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_New_Account) generate_set_password_url() rt.PhpVal {
	mut var_key := rt.call_function('get_password_reset_key', [
		rt.get_property(rt.new_object('WC_Email_Customer_New_Account', ['WC_Email'], &this),
			'object'),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_key.clone()])) {
		return rt.call_function('wc_get_account_endpoint_url', [
			rt.new_string('lost-password'),
		])
	}
	return rt.call_function('sprintf', [
		rt.new_string('%s?action=newaccount&key=%s&login=%s'),
		rt.call_function('wc_get_account_endpoint_url', [rt.new_string('lost-password')]),
		var_key.clone(),
		rt.call_function('rawurlencode', [
			rt.get_property(rt.get_property(rt.new_object('WC_Email_Customer_New_Account', [
				'WC_Email',
			], &this), 'object'), 'user_login'),
		]),
	])
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

fn create_wc_email_customer_new_account() &Class_WC_Email_Customer_New_Account {
	mut obj := &Class_WC_Email_Customer_New_Account{
		PhpObjectBase:      rt.PhpObjectBase{}
		user_login:         rt.new_null()
		user_email:         rt.new_null()
		user_pass:          rt.new_null()
		password_generated: rt.new_null()
		set_password_url:   rt.new_null()
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

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_New_Account) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.trigger(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
		'generate_set_password_url' {
			return this.generate_set_password_url()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_New_Account) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'user_login' { return this.user_login }
		'user_email' { return this.user_email }
		'user_pass' { return this.user_pass }
		'password_generated' { return this.password_generated }
		'set_password_url' { return this.set_password_url }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_New_Account) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'user_login' {
			this.user_login = val
			return true
		}
		'user_email' {
			this.user_email = val
			return true
		}
		'user_pass' {
			this.user_pass = val
			return true
		}
		'password_generated' {
			this.password_generated = val
			return true
		}
		'set_password_url' {
			this.set_password_url = val
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

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('WC_Email_Customer_New_Account'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_New_Account', ['WC_Email'],
		create_wc_email_customer_new_account())
}
