import rt

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_stock_notification_verify'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Back in stock sign-up verification'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Verification e-mail sent to customers, as part of the double opt-in sign-up process.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('template_html',
		rt.new_string('emails/customer-stock-notification-verify.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-stock-notification-verify.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{product_name}', val: '' },
		rt.ArrayItem{ key: '{site_title}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_email_stock_notification_verify_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(1),
	])
	this.Class_WC_Email.construct()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Join the "{product_name}" waitlist.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Confirm sign-up'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_default_intro_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Please follow the link below to complete the sign-up process and join the "{product_name}" waitlist.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Thanks for shopping with us.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_intro_content() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_stock_notification_intro_content'),
		this.format_string(this.get_option_or_transient(rt.new_string('intro_content'),
			this.get_default_intro_content())),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'object'),
		rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'template_html'),
		rt.call_function('array_merge', [
			this.get_additional_template_args(),
			rt.create_array([
				rt.ArrayItem{ key: 'notification', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this), 'object') },
				rt.ArrayItem{ key: 'product', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this), 'object'), 'get_product', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
				rt.ArrayItem{ key: 'intro_content', val: this.get_intro_content() },
				rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
				rt.ArrayItem{ key: 'plain_text', val: false },
				rt.ArrayItem{ key: 'email', val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this) },
			]),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'template_plain'),
		rt.call_function('array_merge', [
			this.get_additional_template_args(),
			rt.create_array([
				rt.ArrayItem{ key: 'notification', val: rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this), 'object') },
				rt.ArrayItem{ key: 'product', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this), 'object'), 'get_product', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
				rt.ArrayItem{ key: 'intro_content', val: this.get_intro_content() },
				rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
				rt.ArrayItem{ key: 'plain_text', val: true },
				rt.ArrayItem{ key: 'email', val: rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
					'WC_Email',
				], &this) },
			]),
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) get_additional_template_args() rt.PhpVal {
	mut var_notification := rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
		'WC_Email',
	], &this), 'object')
	mut var_product := rt.call_method(var_notification, 'get_product', []rt.PhpVal{})
	mut var_verification_button_text := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_stock_notification_verify_button_text'),
		rt.call_function('_x', [rt.new_string('Confirm'),
			rt.new_string('Stock Notification confirm notification'),
			rt.new_string('woocommerce')]),
		var_notification.dup(),
		var_product.dup(),
	])
	mut var_verification_key := rt.call_method(var_notification, 'get_verification_key', [
		rt.new_bool(true),
	])
	mut var_expiration_threshold := fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Config{}
		return temp.get_verification_expiration_time_threshold()
	}()
	mut var_expiration_threshold_text := rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s minute'), rt.new_string('%s minutes'),
			rt.div(var_expiration_threshold, rt.new_int(60)),
			rt.new_string('woocommerce')]),
		rt.call_function('floor', [rt.div(var_expiration_threshold, rt.new_int(60))]),
	])
	return rt.create_array([
		rt.ArrayItem{ key: 'verification_button_text', val: var_verification_button_text },
		rt.ArrayItem{ key: 'verification_expiration_threshold', val: var_expiration_threshold_text },
		rt.ArrayItem{ key: 'verification_link', val: rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'email_link_action_key', val: var_verification_key },
				rt.ArrayItem{ key: 'notification_id', val: rt.call_method(var_notification,
					'get_id', []rt.PhpVal{}) },
			]),
			rt.call_function('get_option', [
				rt.new_string('siteurl'),
			]),
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) trigger(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	this.setup_locale()
	if rt.is_true(rt.new_bool(var_notification_mutated.dup().is_long()
		|| var_notification_mutated.dup().is_double()))
	{
		var_notification_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{}
			return temp.get_notification(arg_0)
		}(var_notification_mutated.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_notification_mutated,
		'Automattic_WooCommerce_Internal_StockNotifications_Notification'))))))
	{
		return rt.new_null()
	}
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')])))))))
	{
		return rt.new_null()
	}
	this.maybe_setup_notification_locale(var_notification_mutated.dup())
	this.prepare_email(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](var_notification_mutated))
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.maybe_restore_notification_locale(var_notification_mutated.dup())
	this.restore_locale()
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) prepare_email(mut var_notification Class_Automattic_WooCommerce_Internal_StockNotifications_Notification) {
	mut var_notification_mutated := var_notification
	this.dispatch_set_prop('object', var_notification_mutated.dup())
	this.dispatch_set_prop('recipient', rt.call_method(var_notification_mutated, 'get_user_email',
		[]rt.PhpVal{}))
	mut var_product := rt.call_method(var_notification_mutated, 'get_product', []rt.PhpVal{})
	rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
		'WC_Email',
	], &this), 'placeholders').array_set('{product_name}', rt.call_function('preg_replace', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'plain_search'),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'plain_replace'),
		rt.call_method(var_product, 'get_name', []rt.PhpVal{}),
	]))
	rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
		'WC_Email',
	], &this), 'placeholders').array_set('{site_title}', rt.call_function('preg_replace', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'plain_search'),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'plain_replace'),
		this.get_blogname(),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) maybe_setup_notification_locale(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_customer_locale := rt.call_method(var_notification_mutated, 'get_meta', [
		rt.new_string('_customer_locale'),
	])
	if !(!rt.is_true(var_customer_locale)) {
		rt.call_function('switch_to_locale', [var_customer_locale.dup()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) maybe_restore_notification_locale(var_notification rt.PhpVal) {
	mut var_notification_mutated := var_notification
	mut var_customer_locale := rt.call_method(var_notification_mutated, 'get_meta', [
		rt.new_string('_customer_locale'),
	])
	if !(!rt.is_true(var_customer_locale)) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) init_form_fields() {
	this.Class_WC_Email.init_form_fields()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
		'WC_Email',
	], &this), 'form_fields').is_array())))))
	{
		return rt.new_null()
	}
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		'<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', ['WC_Email'], &this), 'placeholders'))])])).str() +
			'</code>',
	])
	mut var_intro_content_field := rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Email content'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val:
			(rt.call_function('__', [rt.new_string('Text to appear below the main e-mail header.'), rt.new_string('woocommerce')])).str() +
			' ' + var_placeholder_text.str() },
		rt.ArrayItem{ key: 'css', val: 'width: 400px; height: 75px;' },
		rt.ArrayItem{ key: 'placeholder', val: this.get_default_intro_content() },
		rt.ArrayItem{ key: 'type', val: 'textarea' },
		rt.ArrayItem{ key: 'desc_tip', val: true },
	])
	mut var_inject_index := rt.call_function('array_search', [
		rt.new_string('heading'),
		rt.func_array_keys(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'form_fields')),
		rt.new_bool(true)])
	if rt.is_true(var_inject_index) {
		rt.pre_inc(var_inject_index)
	} else {
		var_inject_index = rt.new_int(rt.new_int(0))
	}
	this.dispatch_set_prop('form_fields', rt.add(rt.add(rt.call_function('array_slice', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'form_fields'),
		rt.new_int(0),
		var_inject_index.dup(),
		rt.new_bool(true),
	]), rt.create_array([
		rt.ArrayItem{ key: 'intro_content', val: var_intro_content_field },
	])), rt.call_function('array_slice', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'form_fields'),
		var_inject_index.dup(),
		rt.sub(rt.new_int(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail', [
			'WC_Email',
		], &this), 'form_fields').array_count()), var_inject_index),
		rt.new_bool(true),
	])))
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_stocknotifications_emails_customerstocknotificationverifyemail() &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail{
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

fn create_automattic_woocommerce_internal_stocknotifications_config() &Class_Automattic_WooCommerce_Internal_StockNotifications_Config {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Config{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_stocknotifications_factory() &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory {
	mut obj := &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_default_intro_content' {
			return this.get_default_intro_content()
		}
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		'get_intro_content' {
			return this.get_intro_content()
		}
		'get_content_html' {
			return this.get_content_html()
		}
		'get_content_plain' {
			return this.get_content_plain()
		}
		'get_additional_template_args' {
			return this.get_additional_template_args()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.trigger(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_email' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_StockNotifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.prepare_email(mut dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_setup_notification_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_setup_notification_locale(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_restore_notification_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_restore_notification_locale(dispatch_arg_0)
			return rt.new_null()
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

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Emails_CustomerStockNotificationVerifyEmail) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Config) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_StockNotifications_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_stocknotifications_emails_customerstocknotificationverifyemail_php() {
	// unsupported statement: Stmt_Declare
}
