import rt

struct Class_WC_Email_Customer_Invoice {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Customer_Invoice) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_invoice'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Order details'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('payments'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-invoice.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/customer-invoice.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Manually send an email to your customers containing their order information and payment links'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Order detail emails can be sent to customers containing their order information and payment links.'),
			rt.new_string('woocommerce'),
		]) })
	this.dispatch_set_prop('manual', rt.new_bool(true))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Payment request'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Manually send customers an email to review their order and complete payment.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Invoice) get_default_subject(paid bool) rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Details for order #{order_number} on {site_title}'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Invoice) get_default_heading(paid bool) rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Details for order #{order_number}'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_Invoice) get_subject() rt.PhpVal {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'object'), 'has_status', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
		]),
	]))
	{
		mut var_subject := this.get_option(rt.new_string('subject_paid'),
			this.get_default_subject(true))
		if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'block_email_editor_enabled'))
		{
			var_subject = rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
				'WC_Email',
			], &this), 'personalizer'), 'personalize_transactional_content', [
				var_subject.dup(), rt.new_object('WC_Email_Customer_Invoice', [
					'WC_Email',
				], &this)])
		}
		return rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_subject_customer_invoice_paid'),
			this.format_string(var_subject.dup()),
			rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
				'object'),
			rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
		])
	}
	var_subject = this.get_option(rt.new_string('subject'), this.get_default_subject(false))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		var_subject = rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'personalizer'), 'personalize_transactional_content', [
			var_subject.dup(), rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this)])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_subject_customer_invoice'),
		this.format_string(var_subject.dup()),
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this), 'object'),
		rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
	])
}

fn (mut this Class_WC_Email_Customer_Invoice) get_heading() rt.PhpVal {
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'object'), 'has_status', [
		rt.call_function('wc_get_is_paid_statuses', []rt.PhpVal{}),
	]))
	{
		mut var_heading := this.get_option(rt.new_string('heading_paid'),
			this.get_default_heading(true))
		return rt.call_function('apply_filters', [
			rt.new_string('woocommerce_email_heading_customer_invoice_paid'),
			this.format_string(var_heading.dup()),
			rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
				'object'),
			rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
		])
	}
	var_heading = this.get_option(rt.new_string('heading'), this.get_default_heading(false))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_heading_customer_invoice'),
		this.format_string(var_heading.dup()),
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this), 'object'),
		rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
	])
}

fn (mut this Class_WC_Email_Customer_Invoice) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Thanks again! If you need any help with your order, please contact us at {store_email}.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Thanks for using {site_url}!'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Customer_Invoice) trigger(var_order_id rt.PhpVal, order bool) {
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
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Invoice) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Invoice', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Invoice) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Invoice', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Invoice) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		'<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this), 'placeholders'))])])).str() +
			'</code>',
	])
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'subject', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Subject'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject(false) },
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
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading(false) },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'subject_paid', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Subject (paid)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject(true) },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'heading_paid', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Email heading (paid)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading(true) },
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
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'form_fields').array_set('cc', this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'form_fields').array_set('bcc', this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Invoice', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		rt.get_property(rt.new_object('WC_Email_Customer_Invoice', ['WC_Email'], &this),
			'form_fields').array_set('preheader', this.get_preheader_field())
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_email_customer_invoice() &Class_WC_Email_Customer_Invoice {
	mut obj := &Class_WC_Email_Customer_Invoice{
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

fn (mut this Class_WC_Email_Customer_Invoice) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_default_subject' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_default_subject(dispatch_arg_0)
		}
		'get_default_heading' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_default_heading(dispatch_arg_0)
		}
		'get_subject' {
			return this.get_subject()
		}
		'get_heading' {
			return this.get_heading()
		}
		'get_default_additional_content' {
			return this.get_default_additional_content()
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
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Invoice) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_Invoice) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_customer_invoice_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Invoice'),
		rt.new_bool(false),
	])))))
	{
	}
	return create_wc_email_customer_invoice()
}
