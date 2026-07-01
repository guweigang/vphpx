import rt

struct Class_WC_Email_Failed_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Failed_Order) construct() {
	this.dispatch_set_prop('id', rt.new_string('failed_order'))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Failed order'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('orders'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/admin-failed-order.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/admin-failed-order.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_pending_to_failed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_on-hold_to_failed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Failed_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Select who should be notified if an order that was previously processing or on-hold has failed.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Failed order emails are sent to chosen recipient(s) when orders have been marked failed (if they were previously pending or on-hold).'),
			rt.new_string('woocommerce'),
		]) })
	this.dispatch_set_prop('recipient', this.get_option(rt.new_string('recipient'), rt.call_function('get_option', [
		rt.new_string('admin_email'),
	])))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this),
		'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies admins when an order that was processing or on hold has failed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Failed_Order) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('[{site_title}]: Order #{order_number} has failed'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Failed_Order) get_default_heading() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Failed_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [rt.new_string('Order failed: #{order_number}'),
			rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('Order Failed: #{order_number}'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Failed_Order) trigger(var_order_id rt.PhpVal, order bool) {
	mut order_mutated := order
	this.setup_locale()
	if rt.is_true(rt.new_bool(rt.is_true(var_order_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).dup(), rt.new_string('WC_Order')])))))))
	{
		order_mutated = (rt.call_function('wc_get_order', [var_order_id.dup()])).to_bool()
	}
	if rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).dup(),
		rt.new_string('WC_Order')]))
	{
		this.dispatch_set_prop('object', rt.new_bool(order_mutated).dup())
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Failed_Order', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Failed_Order) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Failed_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{
				key: 'plain_text'
				val: false
			}, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Failed_Order) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Failed_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{
				key: 'plain_text'
				val: true
			}, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Failed_Order) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Failed_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'sent_to_admin', val: true },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Failed_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Failed_Order) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Failed_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('We hope they’ll be back soon! Read more about <a href="https://woocommerce.com/document/managing-orders/">troubleshooting failed payments</a>.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Hopefully they’ll be back. Read more about <a href="https://woocommerce.com/document/managing-orders/">troubleshooting failed payments</a>.'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Failed_Order) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		'<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'placeholders'))])])).str() +
			'</code>',
	])
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Enable this email notification'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'yes' },
		]) },
		rt.ArrayItem{ key: 'recipient', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Recipient(s)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Enter recipients (comma separated) for this email. Defaults to %s.'),
					rt.new_string('woocommerce'),
				]),
				'<code>' +
					(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('admin_email')])])).str() +
					'</code>',
			]) },
			rt.ArrayItem{ key: 'placeholder', val: '' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'subject', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Subject'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject() },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'heading', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email heading'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading() },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'additional_content', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Additional content'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'description', val:
				(rt.call_function('__', [rt.new_string('Text to appear below the main email content.'), rt.new_string('woocommerce')])).str() +
				' ' + var_placeholder_text.str() },
			rt.ArrayItem{ key: 'css', val: 'width:400px; height: 75px;' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'default', val: this.get_default_additional_content() },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'email_type', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email type'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Choose which format of email to send.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'html' },
			rt.ArrayItem{ key: 'class', val: 'email_type wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: this.get_email_type_options() },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
	]))
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('email_improvements')))
	{
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'form_fields').array_set('cc',
			this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'form_fields').array_set('bcc',
			this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this),
		'block_email_editor_enabled'))
	{
		rt.get_property(rt.new_object('WC_Email_Failed_Order', ['WC_Email'], &this), 'form_fields').array_set('preheader',
			this.get_preheader_field())
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_email_failed_order() &Class_WC_Email_Failed_Order {
	mut obj := &Class_WC_Email_Failed_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_email() &Class_WC_Email {
	mut obj := &Class_WC_Email{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Failed_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
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
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Failed_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Failed_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_failed_order_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Failed_Order'),
		rt.new_bool(false),
	])))))
	{
	}
	return create_wc_email_failed_order()
}
