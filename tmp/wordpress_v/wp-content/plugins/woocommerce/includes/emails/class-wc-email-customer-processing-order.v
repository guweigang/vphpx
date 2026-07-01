import rt

struct Class_WC_Email_Customer_Processing_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Customer_Processing_Order) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_processing_order'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Processing order'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-updates'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-processing-order.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-processing-order.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_cancelled_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_failed_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_on-hold_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_pending_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Send an email to customers notifying them that their order is being processed'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('This is an order notification sent to customers containing order details after payment.'),
			rt.new_string('woocommerce'),
		]) })
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Order confirmation'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when their order has been received and is being processed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Processing_Order) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Your {site_title} order has been received!'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Processing_Order) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Thank you for your order'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_Processing_Order) trigger(var_order_id rt.PhpVal, order bool) {
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
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Processing_Order) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'template_html'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Processing_Order) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
			'WC_Email',
		], &this), 'template_plain'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Processing_Order', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Processing_Order) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Processing_Order', [
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

struct Class_WC_Email {
	rt.PhpObjectBase
}

fn create_wc_email_customer_processing_order() &Class_WC_Email_Customer_Processing_Order {
	mut obj := &Class_WC_Email_Customer_Processing_Order{
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

fn (mut this Class_WC_Email_Customer_Processing_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Processing_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_Processing_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_customer_processing_order_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Processing_Order'),
		rt.new_bool(false),
	])))))
	{
	}
	return create_wc_email_customer_processing_order()
}
