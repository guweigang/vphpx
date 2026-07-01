import rt

struct Class_WC_Email_Customer_Refunded_Order {
	rt.PhpObjectBase
pub mut:
	refund         rt.PhpVal = rt.new_null()
	partial_refund rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) construct() {
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('id', rt.new_string('customer_refunded_order'))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Refunded order'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-changes'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-refunded-order.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-refunded-order.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_fully_refunded_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger_full' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_partially_refunded_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger_partial' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Send an email to customers notifying them when an order has been partially or fully refunded'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Order refunded emails are sent to customers when their orders are refunded.'),
			rt.new_string('woocommerce'),
		]) })
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('Order refunded'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when their order has been partially or fully refunded.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_default_subject(partial bool) rt.PhpVal {
	if var_partial {
		return rt.call_function('__', [
			rt.new_string('Your {site_title} order #{order_number} has been partially refunded'),
			rt.new_string('woocommerce'),
		])
	} else {
		return rt.call_function('__', [
			rt.new_string('Your {site_title} order #{order_number} has been refunded'),
			rt.new_string('woocommerce'),
		])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_default_heading(partial bool) rt.PhpVal {
	if var_partial {
		return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'email_improvements_enabled'))
		{ rt.call_function('__', [rt.new_string('Partial refund: Order {order_number}'),
				rt.new_string('woocommerce')]) } else { rt.call_function('__', [
				rt.new_string('Partial Refund: Order {order_number}'),
				rt.new_string('woocommerce'),
			]) }
	} else {
		return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'email_improvements_enabled'))
		{ rt.call_function('__', [rt.new_string('Order refunded: {order_number}'),
				rt.new_string('woocommerce')]) } else { rt.call_function('__', [
				rt.new_string('Order Refunded: {order_number}'),
				rt.new_string('woocommerce'),
			]) }
	}
	return rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_subject() rt.PhpVal {
	if rt.is_true(this.partial_refund) {
		mut var_subject := this.get_option(rt.new_string('subject_partial'),
			this.get_default_subject(true))
	} else {
		var_subject = this.get_option(rt.new_string('subject_full'),
			this.get_default_subject(false))
	}
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_subject_customer_refunded_order'),
		this.format_string(var_subject.dup()),
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'object'),
		rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
	])
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		var_subject = rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'personalizer'), 'personalize_transactional_content', [
			var_subject.dup(), rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this)])
	}
	return var_subject.dup()
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_heading() rt.PhpVal {
	if rt.is_true(this.partial_refund) {
		mut var_heading := this.get_option(rt.new_string('heading_partial'),
			this.get_default_heading(true))
	} else {
		var_heading = this.get_option(rt.new_string('heading_full'),
			this.get_default_heading(false))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_heading_customer_refunded_order'),
		this.format_string(var_heading.dup()),
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'object'),
		rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
	])
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) set_email_strings(partial_refund bool) {
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) trigger_full(var_order_id rt.PhpVal, var_refund_id rt.PhpVal) {
	this.trigger(var_order_id.dup(), false, var_refund_id.dup())
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) trigger_partial(var_order_id rt.PhpVal, var_refund_id rt.PhpVal) {
	this.trigger(var_order_id.dup(), true, var_refund_id.dup())
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) trigger(var_order_id rt.PhpVal, partial_refund bool, var_refund_id rt.PhpVal) {
	this.setup_locale()
	this.partial_refund = rt.new_bool(partial_refund).dup()
	this.dispatch_set_prop('id', if rt.is_true(this.partial_refund) {
		rt.new_string('customer_partially_refunded_order')
	} else {
		rt.new_string('customer_refunded_order')
	})
	if rt.is_true(var_order_id) {
		this.dispatch_set_prop('object', rt.call_function('wc_get_order', [
			var_order_id.dup()]))
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if !(!rt.is_true(var_refund_id)) {
		this.refund = rt.call_function('wc_get_order', [var_refund_id.dup()])
	} else {
		this.refund = rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'refund', val: this.refund },
			rt.ArrayItem{ key: 'partial_refund', val: this.partial_refund },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'refund', val: this.refund },
			rt.ArrayItem{ key: 'partial_refund', val: this.partial_refund },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'blogname', val: this.get_blogname() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'refund', val: this.refund },
			rt.ArrayItem{ key: 'partial_refund', val: this.partial_refund },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Refunded_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('If you need any help with your order, please contact us at {store_email}.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('We hope to see you again soon.'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		'<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this), 'placeholders'))])])).str() +
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
		rt.ArrayItem{ key: 'subject_full', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Full refund subject'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject(false) },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'subject_partial', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Partial refund subject'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject(true) },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'heading_full', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Full refund email heading'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'description', val: var_placeholder_text },
			rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading(false) },
			rt.ArrayItem{ key: 'default', val: '' },
		]) },
		rt.ArrayItem{ key: 'heading_partial', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Partial refund email heading'),
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
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'form_fields').array_set('cc', this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'form_fields').array_set('bcc', this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		rt.get_property(rt.new_object('WC_Email_Customer_Refunded_Order', ['WC_Email'], &this),
			'form_fields').array_set('preheader', this.get_preheader_field())
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_email_customer_refunded_order() &Class_WC_Email_Customer_Refunded_Order {
	mut obj := &Class_WC_Email_Customer_Refunded_Order{
		PhpObjectBase:  rt.PhpObjectBase{}
		refund:         rt.new_null()
		partial_refund: rt.new_null()
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

fn (mut this Class_WC_Email_Customer_Refunded_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'set_email_strings' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_email_strings(dispatch_arg_0)
			return rt.new_null()
		}
		'trigger_full' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger_full(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'trigger_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger_partial(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
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
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Refunded_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'refund' { return this.refund }
		'partial_refund' { return this.partial_refund }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'refund' {
			this.refund = val
			return true
		}
		'partial_refund' {
			this.partial_refund = val
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

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_customer_refunded_order_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Refunded_Order'),
		rt.new_bool(false),
	])))))
	{
	}
	return create_wc_email_customer_refunded_order()
}
