import rt

struct Class_WC_Email_New_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_New_Order) construct() {
	this.dispatch_set_prop('id', rt.new_string('new_order'))
	this.dispatch_set_prop('title', rt.call_function('__', [rt.new_string('New order'),
		rt.new_string('woocommerce')]))
	this.dispatch_set_prop('email_group', rt.new_string('orders'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/admin-new-order.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/admin-new-order.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_pending_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_pending_to_completed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_pending_to_on-hold_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
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
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_failed_to_completed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_failed_to_on-hold_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_cancelled_to_processing_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_cancelled_to_completed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_cancelled_to_on-hold_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'mobile_messaging' },
		]),
		rt.new_int(9)])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Receive an email notification every time a new order is placed'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('New order emails are sent to chosen recipient(s) when a new order is received.'),
			rt.new_string('woocommerce'),
		]) })
	this.dispatch_set_prop('recipient', this.get_option(rt.new_string('recipient'), rt.call_function('get_option', [
		rt.new_string('admin_email'),
	])))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this),
		'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies admins when a new order has been placed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_New_Order) get_default_subject() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string("[{site_title}]: You've got a new order: #{order_number}"),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('[{site_title}]: New order #{order_number}'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_New_Order) get_default_heading() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [rt.new_string('New order: #{order_number}'),
			rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('New Order: #{order_number}'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_New_Order) trigger(var_order_id rt.PhpVal, order bool) {
	mut order_mutated := order
	this.setup_locale()
	if rt.is_true(var_order_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).clone(), rt.new_string('WC_Order')]))))) {
		order_mutated = (rt.call_function('wc_get_order', [var_order_id.clone()])).to_bool()
	}
	mut var_email_already_sent := rt.new_bool(false)
	if rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).clone(),
		rt.new_string('WC_Order')]))
	{
		this.dispatch_set_prop('object', rt.new_bool(order_mutated).clone())
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_New_Order', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
		var_email_already_sent = rt.call_method(rt.new_bool(order_mutated),
			'get_new_order_email_sent', []rt.PhpVal{})
	}
	if rt.is_true(var_email_already_sent)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_new_order_email_allows_resend'), rt.new_bool(false)]))))) {
		return
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()) {
		mut var_email_sent_successfully := this.send(this.get_recipient(), this.get_subject(),
			this.get_content(), this.get_headers(), this.get_attachments())
		if rt.is_true(var_email_sent_successfully) {
			rt.call_method(rt.new_bool(order_mutated), 'update_meta_data', [
				rt.new_string('_new_order_email_sent'),
				rt.new_string('true'),
			])
			rt.call_method(rt.new_bool(order_mutated), 'save', []rt.PhpVal{})
		}
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_New_Order) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'template_html'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_New_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{
				key: 'plain_text'
				val: false
			}, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_New_Order) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'template_plain'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_New_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{
				key: 'plain_text'
				val: true
			}, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_New_Order) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this),
			'template_block_content'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_New_Order', [
			'WC_Email',
		], &this), 'object') }, rt.ArrayItem{ key: 'sent_to_admin', val: true },
			rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_New_Order', [
				'WC_Email',
			], &this) }]),
	])
}

fn (mut this Class_WC_Email_New_Order) get_default_additional_content() rt.PhpVal {
	return if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [rt.new_string('Congratulations on the sale!'),
			rt.new_string('woocommerce')]) } else { rt.call_function('__', [
			rt.new_string('Congratulations on the sale.'),
			rt.new_string('woocommerce'),
		]) }
}

fn (mut this Class_WC_Email_New_Order) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<code>' +
			(rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'placeholders'))])).str() +
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
				rt.new_string('<code>' +
					(rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('admin_email')])])).str() +
					'</code>'),
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
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_0) {
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'form_fields').array_set('cc',
			this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'form_fields').array_set('bcc',
			this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this),
		'block_email_editor_enabled'))
	{
		rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'form_fields').array_set('preheader',
			this.get_preheader_field())
	}
}

fn (mut this Class_WC_Email_New_Order) mobile_messaging(var_email rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_email, 'WC_Email_New_Order')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(rt.new_object('WC_Email_New_Order', ['WC_Email'], &this), 'object'))))) {
		mut var_domain := rt.call_function('wp_parse_url', [
			rt.call_function('home_url', []rt.PhpVal{}),
			rt.get_constant('PHP_URL_HOST'),
		])
		mut iife_temp_1 := Class_Jetpack_Options{}
		mut iife_result_1 := iife_temp_1.get_option(rt.new_string('id'))
		rt.call_function('wc_get_template', [
			rt.new_string('emails/email-mobile-messaging.php'),
			rt.create_array([
				rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_New_Order', [
					'WC_Email',
				], &this), 'object') },
				rt.ArrayItem{
					key: 'blog_id'
					val: if rt.is_true(rt.call_function('class_exists', [
						rt.new_string('Jetpack_Options'),
					]))
					{ iife_result_1 } else { rt.new_null() }
				},
				rt.ArrayItem{ key: 'now', val: create_datetime() },
				rt.ArrayItem{
					key: 'domain'
					val: if var_domain.clone().is_string() { var_domain } else { rt.new_string('') }
				},
			]),
		])
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Jetpack_Options {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_email_new_order() &Class_WC_Email_New_Order {
	mut obj := &Class_WC_Email_New_Order{
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

fn create_jetpack_options(_args ...rt.PhpVal) &Class_Jetpack_Options {
	mut obj := &Class_Jetpack_Options{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_New_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'mobile_messaging' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.mobile_messaging(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_New_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_New_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Jetpack_Options) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_Options) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_Options) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('WC_Email_New_Order'),
	])))))
	{
	}
	return rt.new_object('WC_Email_New_Order', ['WC_Email'], create_wc_email_new_order())
}
