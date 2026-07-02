import rt

pub fn Class_WC_Email_Customer_Review_Request.min_delay_days() i64 {
	return 1
}

pub fn Class_WC_Email_Customer_Review_Request.max_delay_days() i64 {
	return 60
}

pub fn Class_WC_Email_Customer_Review_Request.default_delay_days() i64 {
	return 7
}

struct Class_WC_Email_Customer_Review_Request {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Customer_Review_Request) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_review_request'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Review request'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-updates'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/customer-review-request.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-review-request.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_send_review_request_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Review_Request', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Review request emails are sent to customers a few days after their order is complete, inviting them to leave reviews for the products they purchased.'),
		rt.new_string('woocommerce'),
	]))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Invites customers to review the products from their completed order.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_Review_Request) trigger(var_order_id rt.PhpVal) {
	this.setup_locale()
	this.dispatch_set_prop('object', rt.new_bool(false))
	this.dispatch_set_prop('recipient', rt.new_string(''))
	rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
		'placeholders').array_set('{order_date}', '')
	rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
		'placeholders').array_set('{order_number}', '')
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [
			var_order_id.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		this.dispatch_set_prop('object', var_order.clone())
		this.dispatch_set_prop('recipient', rt.call_method(var_order, 'get_billing_email',
			[]rt.PhpVal{}))
		mut var_date_created := rt.call_method(var_order, 'get_date_created', []rt.PhpVal{})
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'placeholders').array_set('{order_date}', if rt.is_true(var_date_created) { rt.call_function('wc_format_datetime', [
				var_date_created.clone(),
			]) } else { rt.new_string('') })
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'placeholders').array_set('{order_number}', rt.call_method(var_order,
			'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient())
		&& this.is_order_eligible_for_send() {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Review_Request) is_order_eligible_for_send() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
		'WC_Email',
	], &this), 'object'), 'WC_Order'))))))
	{
		return false
	}
	mut var_eligible_statuses := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
		]),
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
			'WC_Email',
		], &this), 'object'),
	]))
	return (rt.call_function('in_array', [
		rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
			'WC_Email',
		], &this), 'object'), 'get_status', []rt.PhpVal{}),
		var_eligible_statuses.clone(),
		rt.new_bool(true),
	])).to_bool()
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('How was your order from {site_title}?'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Rate your recent purchases'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string("Thanks again for shopping with us. If you have any questions, reply to this email and we'll help out."),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_review_order_url() rt.PhpVal {
	return if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
		'WC_Email',
	], &this), 'object'), 'WC_Order')))
	{ rt.call_function('wc_get_review_order_url', [
			rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
				'WC_Email',
			], &this), 'object'),
		]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_delay_seconds() i64 {
	mut var_delay_days := rt.new_int((this.get_option(rt.new_string('delay_days'),
		Class_WC_Email_Customer_Review_Request.default_delay_days())).to_i64())
	var_delay_days = rt.call_function('max', [
		Class_WC_Email_Customer_Review_Request.min_delay_days(),
		rt.call_function('min', [
			Class_WC_Email_Customer_Review_Request.max_delay_days(),
			var_delay_days.clone(),
		]),
	])
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_request_delay_seconds'),
		rt.mul(var_delay_days, rt.get_constant('DAY_IN_SECONDS')),
	])).to_i64())
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'review_order_url', val: this.get_review_order_url() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Review_Request', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Review_Request) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'review_order_url', val: this.get_review_order_url() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Review_Request', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_Customer_Review_Request) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<code>' +
			(rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.call_function('array_map', [rt.new_string('esc_html'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this), 'placeholders'))])])).str() +
			'</code>'),
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
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
		rt.ArrayItem{ key: 'delay_days', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Delay (days)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How many days after the order is marked complete before the review request email is sent.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'default'
				val: (Class_WC_Email_Customer_Review_Request.default_delay_days()).str()
			},
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{
					key: 'min'
					val: (Class_WC_Email_Customer_Review_Request.min_delay_days()).str()
				},
				rt.ArrayItem{
					key: 'max'
					val: (Class_WC_Email_Customer_Review_Request.max_delay_days()).str()
				},
				rt.ArrayItem{ key: 'step', val: '1' },
			]) },
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
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_0) {
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'form_fields').array_set('cc', this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'form_fields').array_set('bcc', this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		rt.get_property(rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'], &this),
			'form_fields').array_set('preheader', this.get_preheader_field())
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_email_customer_review_request() &Class_WC_Email_Customer_Review_Request {
	mut obj := &Class_WC_Email_Customer_Review_Request{
		PhpObjectBase: rt.PhpObjectBase{}
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

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_Review_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.trigger(dispatch_arg_0)
			return rt.new_null()
		}
		'is_order_eligible_for_send' {
			return rt.new_bool(this.is_order_eligible_for_send())
		}
		'get_default_subject' {
			return this.get_default_subject()
		}
		'get_default_heading' {
			return this.get_default_heading()
		}
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		'get_review_order_url' {
			return this.get_review_order_url()
		}
		'get_delay_seconds' {
			return rt.new_int(this.get_delay_seconds())
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

fn (this &Class_WC_Email_Customer_Review_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_Review_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Review_Request'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_Review_Request', ['WC_Email'],
		create_wc_email_customer_review_request())
}
