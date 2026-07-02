import rt

struct Class_WC_Email_Customer_Note {
	rt.PhpObjectBase
pub mut:
	customer_note rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Note) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_note'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Customer note'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-changes'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-note.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/customer-note.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_new_customer_note_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Note', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Send an email to customers notifying them when you’ve added a note to their order'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Customer note emails are sent when you add a note to an order.'),
			rt.new_string('woocommerce'),
		]) })
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
		'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Customer note added'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when you’ve added a note to their order.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Note) get_default_subject() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('A note has been added to your order from {site_title}'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Note added to your {site_title} order from {order_date}'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Customer_Note) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('A note has been added to your order'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_Note) trigger(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.setup_locale()
	if !(!rt.is_true(var_args_mutated)) {
		mut var_defaults := {
			'order_id':      ''
			'customer_note': ''
		}
		var_args_mutated = rt.call_function('wp_parse_args', [
			var_args_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
		mut var_order_id := var_args_mutated.array_get(rt.new_string('order_id'))
		mut var_customer_note := var_args_mutated.array_get(rt.new_string('customer_note'))
		if rt.is_true(var_order_id) {
			this.dispatch_set_prop('object', rt.call_function('wc_get_order', [
				var_order_id.clone(),
			]))
			if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
				'WC_Email',
			], &this), 'object'))
			{
				this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
					'WC_Email',
				], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
				this.customer_note = var_customer_note.clone()
				rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
					'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
					rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
						'WC_Email',
					], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
				]))
				rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
					'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
					'WC_Email',
				], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
			}
		}
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Note) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Note', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Note', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Note) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Note', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Note', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Note) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Note', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Thanks again! If you need any help with your order, please contact us at {store_email}.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [rt.new_string('Thanks for reading.'),
			rt.new_string('woocommerce')]) }
}

fn (mut this Class_WC_Email_Customer_Note) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Note', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Note', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Note', [
				'WC_Email',
			], &this) }]),
	])
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

fn create_wc_email_customer_note() &Class_WC_Email_Customer_Note {
	mut obj := &Class_WC_Email_Customer_Note{
		PhpObjectBase: rt.PhpObjectBase{}
		customer_note: rt.new_null()
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

fn (mut this Class_WC_Email_Customer_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			this.trigger(dispatch_arg_0)
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
		'get_block_editor_email_template_content' {
			return this.get_block_editor_email_template_content()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'customer_note' { return this.customer_note }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'customer_note' {
			this.customer_note = val
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
		rt.new_string('WC_Email_Customer_Note'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_Note', ['WC_Email'], create_wc_email_customer_note())
}
