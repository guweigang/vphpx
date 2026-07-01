import rt

struct Class_WC_Email_Admin_Payment_Gateway_Enabled {
	rt.PhpObjectBase
pub mut:
			gateway_title rt.PhpVal = rt.new_string('')
			gateway_settings_url rt.PhpVal = rt.new_string('')
			username rt.PhpVal = rt.new_string('')
			admin_email rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) construct()  {
	this.dispatch_set_prop('id', rt.new_string('admin_payment_gateway_enabled'))
	this.dispatch_set_prop('title', rt.call_function('__', [rt.new_string('Payment gateway enabled'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('email_group', rt.new_string('payments'))
	this.dispatch_set_prop('template_html', rt.new_string('emails/admin-payment-gateway-enabled.php'))
	this.dispatch_set_prop('template_plain', rt.new_string('emails/plain/admin-payment-gateway-enabled.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([rt.ArrayItem{ key: '{gateway_title}', val: '' }, rt.ArrayItem{ key: '{site_title}', val: '' }]))
	rt.call_function('add_action', [rt.new_string('woocommerce_payment_gateway_enabled_notification'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }, rt.ArrayItem{ key: none, val: 'trigger' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_general_block_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }, rt.ArrayItem{ key: none, val: 'block_content' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_emails_general_block_content_emails_without_order_details'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }, rt.ArrayItem{ key: none, val: 'exclude_from_order_details' }])])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', rt.call_function('__', [rt.new_string('Payment gateway enabled emails are sent to chosen recipient(s) when a payment gateway is enabled.'), rt.new_string('woocommerce')]))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'block_email_editor_enabled')) {
		this.dispatch_set_prop('description', rt.call_function('__', [rt.new_string('Notifies admins when a payment gateway has been enabled.'), rt.new_string('woocommerce')]))
	}
	this.dispatch_set_prop('recipient', this.get_option(rt.new_string('recipient'), rt.call_function('get_option', [rt.new_string('admin_email')])))
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('[{site_title}] Payment gateway "{gateway_title}" enabled'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Payment gateway "{gateway_title}" enabled'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) trigger(var_gateway rt.PhpVal)  {
	this.setup_locale()
	if rt.is_true(rt.call_function('is_a', [var_gateway.dup(), rt.new_string('WC_Payment_Gateway')])) {
		this.dispatch_set_prop('object', var_gateway.dup())
		this.gateway_title = rt.call_method(var_gateway, 'get_method_title', []rt.PhpVal{})
		this.gateway_settings_url = rt.call_function('esc_url_raw', [rt.call_function('self_admin_url', ['admin.php?page=wc-settings&tab=checkout&section=' + (rt.get_property(var_gateway, 'id')).str()])])
		this.gateway_settings_url = rt.call_function('apply_filters', [rt.new_string('woocommerce_payment_gateway_enabled_notification_settings_url'), this.gateway_settings_url, var_gateway.dup()])
		this.admin_email = rt.call_function('get_option', [rt.new_string('admin_email')])
		mut var_user := rt.call_function('get_user_by', [rt.new_string('email'), this.admin_email])
		this.username = if rt.is_true(var_user) { rt.get_property(var_user, 'user_login') } else { this.admin_email }
		rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'placeholders').array_set('{gateway_title}', this.gateway_title)
		rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'placeholders').array_set('{site_title}', this.get_blogname())
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(), this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_recipient() rt.PhpVal {
	mut var_recipient := this.Class_WC_Email.get_recipient()
	if rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'object'), 'WC_Payment_Gateway'))) {
		mut var_extra_addresses := rt.call_function('apply_filters', [rt.new_string('wc_payment_gateway_enabled_notification_email_addresses'), rt.new_array(), rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'object')])
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_extra_addresses)) && rt.is_true(rt.new_bool(var_extra_addresses.dup().is_array())))) {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_email_address := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_Cast_Bool
	}
			mut var_extra_valid := rt.call_function('array_filter', [var_extra_addresses.dup(), rt.new_closure(closure_1_fn)])
			if !(!rt.is_true(var_extra_valid)) {
				mut var_existing := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_recipient.dup()])])
				mut var_merged := rt.call_function('array_unique', [rt.call_function('array_merge', [var_existing.dup(), var_extra_valid.dup()])])
				var_recipient = rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_filter', [var_merged.dup()])])
			}
		}
	}
	return var_recipient.dup()
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_content_html() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'template_html'), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'object') }, rt.ArrayItem{ key: 'gateway_title', val: this.gateway_title }, rt.ArrayItem{ key: 'gateway_settings_url', val: this.gateway_settings_url }, rt.ArrayItem{ key: 'username', val: this.username }, rt.ArrayItem{ key: 'admin_email', val: this.admin_email }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() }, rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() }, rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }])])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_content_plain() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'template_plain'), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'object') }, rt.ArrayItem{ key: 'gateway_title', val: this.gateway_title }, rt.ArrayItem{ key: 'gateway_settings_url', val: this.gateway_settings_url }, rt.ArrayItem{ key: 'username', val: this.username }, rt.ArrayItem{ key: 'admin_email', val: this.admin_email }, rt.ArrayItem{ key: 'email_heading', val: this.get_heading() }, rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() }, rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{ key: 'plain_text', val: true }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }])])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'template_block_content'), rt.create_array([rt.ArrayItem{ key: 'gateway', val: rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'object') }, rt.ArrayItem{ key: 'gateway_title', val: this.gateway_title }, rt.ArrayItem{ key: 'gateway_settings_url', val: this.gateway_settings_url }, rt.ArrayItem{ key: 'username', val: this.username }, rt.ArrayItem{ key: 'admin_email', val: this.admin_email }, rt.ArrayItem{ key: 'sent_to_admin', val: true }, rt.ArrayItem{ key: 'plain_text', val: false }, rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this) }])])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) block_content(var_sent_to_admin rt.PhpVal, var_plain_text rt.PhpVal, var_email rt.PhpVal)  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_gateway_title := if !(!rt.is_true(this.gateway_title)) { this.gateway_title } else { rt.call_function('__', [rt.new_string('Dummy Gateway'), rt.new_string('woocommerce')]) }
	mut var_gateway_settings_url := if !(!rt.is_true(this.gateway_settings_url)) { this.gateway_settings_url } else { rt.call_function('__', [rt.new_string('Dummy Settings URL'), rt.new_string('woocommerce')]) }
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('esc_html__', [rt.new_string('The payment gateway "%s" has been enabled.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_gateway_title.dup()])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('If you did not enable this payment gateway, please log in to your site and consider disabling it here:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_gateway_settings_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_gateway_settings_url.dup()]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) exclude_from_order_details(var_emails_without_order_details rt.PhpVal) rt.PhpVal {
	mut var_emails_without_order_details_mutated := var_emails_without_order_details
	var_emails_without_order_details_mutated.array_push('admin_payment_gateway_enabled')
	return var_emails_without_order_details_mutated.dup()
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('If this was intentional, you can safely ignore and delete this email.'), rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) init_form_fields()  {
	mut var_placeholder_text := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Available placeholders: %s'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'placeholders'))])])).str() + '</code>'])
	this.dispatch_set_prop('form_fields', rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable this email notification'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: 'yes' }]) }, rt.ArrayItem{ key: 'recipient', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Recipient(s)'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Enter recipients (comma separated) for this email. Defaults to %s.'), rt.new_string('woocommerce')]), '<code>' + (rt.call_function('esc_attr', [rt.call_function('get_option', [rt.new_string('admin_email')])])).str() + '</code>']) }, rt.ArrayItem{ key: 'placeholder', val: '' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'subject', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Subject'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: var_placeholder_text }, rt.ArrayItem{ key: 'placeholder', val: this.get_default_subject() }, rt.ArrayItem{ key: 'default', val: '' }]) }, rt.ArrayItem{ key: 'heading', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email heading'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'text' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'description', val: var_placeholder_text }, rt.ArrayItem{ key: 'placeholder', val: this.get_default_heading() }, rt.ArrayItem{ key: 'default', val: '' }]) }, rt.ArrayItem{ key: 'additional_content', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Additional content'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: (rt.call_function('__', [rt.new_string('Text to appear below the main email content.'), rt.new_string('woocommerce')])).str() + ' ' + (var_placeholder_text).str() }, rt.ArrayItem{ key: 'css', val: 'width:400px; height: 75px;' }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('N/A'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'default', val: this.get_default_additional_content() }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'email_type', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Email type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Choose which format of email to send.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: 'html' }, rt.ArrayItem{ key: 'class', val: 'email_type wc-enhanced-select' }, rt.ArrayItem{ key: 'options', val: this.get_email_type_options() }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }]))
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}; return temp.feature_is_enabled(arg_0) }(rt.new_string('email_improvements'))) {
		rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'form_fields').array_set('cc', this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'form_fields').array_set('bcc', this.get_bcc_field())
	}
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'block_email_editor_enabled')) {
		rt.get_property(rt.new_object('WC_Email_Admin_Payment_Gateway_Enabled', ['WC_Email'], &this), 'form_fields').array_set('preheader', this.get_preheader_field())
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_wc_email_admin_payment_gateway_enabled() &Class_WC_Email_Admin_Payment_Gateway_Enabled {
	mut obj := &Class_WC_Email_Admin_Payment_Gateway_Enabled{
		PhpObjectBase: rt.PhpObjectBase{}
		gateway_title: rt.new_string('')
		gateway_settings_url: rt.new_string('')
		username: rt.new_string('')
		admin_email: rt.new_string('')
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

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_recipient' {
			return this.get_recipient()
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
		'block_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.block_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'exclude_from_order_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.exclude_from_order_details(dispatch_arg_0)
		}
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Email_Admin_Payment_Gateway_Enabled) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'gateway_title' { return this.gateway_title }
		'gateway_settings_url' { return this.gateway_settings_url }
		'username' { return this.username }
		'admin_email' { return this.admin_email }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Admin_Payment_Gateway_Enabled) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'gateway_title' { this.gateway_title = val; return true }
		'gateway_settings_url' { this.gateway_settings_url = val; return true }
		'username' { this.username = val; return true }
		'admin_email' { this.admin_email = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_admin_payment_gateway_enabled_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Email_Admin_Payment_Gateway_Enabled'), rt.new_bool(false)]))))) {
	}
	return create_wc_email_admin_payment_gateway_enabled()
}
