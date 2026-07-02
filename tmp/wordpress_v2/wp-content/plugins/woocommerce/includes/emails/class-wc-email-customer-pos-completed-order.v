import rt

struct Class_WC_Email_Customer_POS_Completed_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_pos_completed_order'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('POS completed order'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('payments'))
	this.dispatch_set_prop('template_html',
		rt.new_string('emails/customer-pos-completed-order.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-pos-completed-order.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	this.enable_order_email_actions_for_pos_orders()
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
		'WC_Email',
	], &this), 'email_improvements_enabled'))
	{ rt.call_function('__', [
			rt.new_string('Let customers know once their POS order is complete.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Order complete emails are sent to customers when their POS orders are marked completed.'),
			rt.new_string('woocommerce'),
		]) })
	this.dispatch_set_prop('manual', rt.new_bool(true))
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
		'WC_Email',
	], &this), 'block_email_editor_enabled'))
	{
		this.dispatch_set_prop('title', rt.call_function('__', [
			rt.new_string('POS order complete'),
			rt.new_string('woocommerce'),
		]))
		this.dispatch_set_prop('description', rt.call_function('__', [
			rt.new_string('Notifies customers when their in-person (POS) order has been completed.'),
			rt.new_string('woocommerce'),
		]))
	}
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) trigger(var_order_id rt.PhpVal, var_template_id rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
		'WC_Email',
	], &this), 'id'), var_template_id))))
	{
		return
	}
	this.setup_locale()
	if rt.is_true(var_order_id) {
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	}
	if rt.is_true(rt.call_function('is_a', [var_order.clone(),
		rt.new_string('WC_Order')]))
	{
		this.dispatch_set_prop('object', var_order.clone())
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_default_subject() rt.PhpVal {
	mut var_store_name := this.get_pos_store_name()
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Your in-store purchase #%1$s at %2$s'),
			rt.new_string('woocommerce')]),
		rt.new_string('{order_number}'),
		rt.call_function('esc_html', [var_store_name.clone()]),
	])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Thank you for your in-store purchase'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_content_html() rt.PhpVal {
	this.add_pos_customizations()
	rt.call_function('add_action', [rt.new_string('woocommerce_pos_email_header'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_header' },
		])])
	rt.call_function('add_action', [rt.new_string('woocommerce_pos_email_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_footer' },
		])])
	mut var_content := rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'template_html'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'pos_store_name', val: this.get_pos_store_name() },
			rt.ArrayItem{ key: 'pos_store_email', val: this.get_pos_store_email() },
			rt.ArrayItem{ key: 'pos_store_phone_number', val: this.get_pos_store_phone_number() },
			rt.ArrayItem{ key: 'pos_store_address', val: this.get_pos_store_address() },
			rt.ArrayItem{
				key: 'pos_refund_returns_policy'
				val: this.get_pos_refund_returns_policy()
			},
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
		]),
	])
	this.remove_pos_customizations()
	rt.call_function('remove_action', [rt.new_string('woocommerce_pos_email_header'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_header' },
		])])
	rt.call_function('remove_action', [rt.new_string('woocommerce_pos_email_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'email_footer' },
		])])
	return var_content.clone()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_content_plain() rt.PhpVal {
	this.add_pos_customizations()
	mut var_content := rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'template_plain'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'pos_store_name', val: this.get_pos_store_name() },
			rt.ArrayItem{ key: 'pos_store_email', val: this.get_pos_store_email() },
			rt.ArrayItem{ key: 'pos_store_phone_number', val: this.get_pos_store_phone_number() },
			rt.ArrayItem{ key: 'pos_store_address', val: this.get_pos_store_address() },
			rt.ArrayItem{
				key: 'pos_refund_returns_policy'
				val: this.get_pos_refund_returns_policy()
			},
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
		]),
	])
	this.remove_pos_customizations()
	return var_content.clone()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_block_editor_email_template_content() rt.PhpVal {
	this.add_pos_customizations()
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'template_block_content'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) auto_trigger(var_order_id rt.PhpVal, order bool) {
	mut order_mutated := order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(order_mutated),
		'WC_Order'))))))
	{
		order_mutated = (rt.call_function('wc_get_order', [var_order_id.clone()])).to_bool()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{}
	mut iife_result_0 := iife_temp_0.is_order_paid_at_pos(rt.new_bool(order_mutated))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_bool(order_mutated), 'WC_Order'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		return
	}
	this.trigger(var_order_id.clone(), rt.new_string((rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
		'WC_Email',
	], &this), 'id')).str()))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) enable_order_email_actions_for_pos_orders() {
	rt.call_function('add_action', [
		rt.new_string('woocommerce_order_status_completed_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'auto_trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	this.enable_email_template_for_pos_orders()
	rt.call_function('add_action', [
		rt.new_string('woocommerce_rest_order_actions_email_send'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) init_form_fields() {
	mut var_placeholder_text := rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Available placeholders: %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('<code>' +
			(rt.call_function('esc_html', [rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', ['WC_Email'], &this), 'placeholders'))])])).str() +
			'</code>'),
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
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_1 := iife_temp_1.feature_is_enabled(rt.new_string('email_improvements'))
	if rt.is_true(iife_result_1) {
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'form_fields').array_set('cc', this.get_cc_field())
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'form_fields').array_set('bcc', this.get_bcc_field())
	}
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) add_pos_customizations() {
	rt.call_function('add_action', [rt.new_string('woocommerce_order_item_meta_start'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_unit_price' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_order_item_totals'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_item_totals' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_email_footer_text'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'replace_footer_placeholders' },
		]),
		rt.new_int(1), rt.new_int(2)])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) remove_pos_customizations() {
	rt.call_function('remove_action', [
		rt.new_string('woocommerce_order_item_meta_start'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_unit_price' },
		]),
		rt.new_int(10),
	])
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_get_order_item_totals'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'order_item_totals' },
		]),
		rt.new_int(10),
	])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_email_footer_text'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'replace_footer_placeholders' },
		]),
		rt.new_int(1)])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) email_header(var_email_heading rt.PhpVal) {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-header.php'),
		rt.create_array([rt.ArrayItem{ key: 'email_heading', val: var_email_heading },
			rt.ArrayItem{ key: 'store_name', val: this.get_pos_store_name() }])])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) email_footer(var_email rt.PhpVal) {
	rt.call_function('wc_get_template', [rt.new_string('emails/email-footer.php'),
		rt.create_array([rt.ArrayItem{ key: 'email', val: var_email }])])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) add_unit_price(var_item_id rt.PhpVal, var_item rt.PhpVal, var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter{}
	mut iife_result_2 := iife_temp_2.get_formatted_item_subtotal(var_order_mutated.clone(),
		var_item.clone(), rt.call_function('get_option', [
		rt.new_string('woocommerce_tax_display_cart'),
	]))
	mut var_unit_price := iife_result_2
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.new_string('<br /><small>' + var_unit_price.str() + '</small>'),
	]))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) order_item_totals(var_total_rows rt.PhpVal, var_order rt.PhpVal, var_tax_display rt.PhpVal) rt.PhpVal {
	mut var_total_rows_mutated := var_total_rows
	mut var_order_mutated := var_order
	mut var_cash_payment_change_due_amount := rt.call_method(var_order_mutated, 'get_meta', [
		rt.new_string('_cash_change_amount'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
		var_cash_payment_change_due_amount))))
	{
		mut var_formatted_cash_payment_change_due_amount := rt.call_function('wc_price', [
			var_cash_payment_change_due_amount.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order_mutated,
					'get_currency', []rt.PhpVal{}) },
			]),
		])
		var_total_rows_mutated.array_set('cash_payment_change_due_amount', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'cash_payment_change_due_amount' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Change due:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_formatted_cash_payment_change_due_amount },
		]))
	}
	mut var_auth_code := rt.call_method(var_order_mutated, 'get_meta', [
		rt.new_string('_charge_id'),
		rt.new_bool(true),
	])
	if !(!rt.is_true(var_auth_code)) {
		var_total_rows_mutated.array_set('payment_auth_code', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'payment_auth_code' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Auth code:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: var_auth_code },
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_order_mutated,
		'get_date_paid', []rt.PhpVal{}), rt.new_null()))))
	{
		var_total_rows_mutated.array_set('date_paid', rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'date_paid' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Time of payment:'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_datetime', [
				rt.call_method(var_order_mutated, 'get_date_paid', []rt.PhpVal{}),
				rt.new_string(
					(rt.call_function('get_option', [rt.new_string('date_format')])).str() + ' ' +
					(rt.call_function('get_option', [rt.new_string('time_format')])).str()),
			]) },
		]))
	}
	return var_total_rows_mutated.clone()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) enable_email_template_for_pos_orders() {
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_order_actions_email_valid_template_classes'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_to_valid_template_classes' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_rest_order_actions_email_preferred_template_ids'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_POS_Completed_Order', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_to_preferred_template_ids' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) add_to_valid_template_classes(var_valid_template_classes rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_valid_template_classes_mutated := var_valid_template_classes
	mut var_order_mutated := var_order
	if !(this.is_applicable_for_order(var_order_mutated.clone())) {
		return var_valid_template_classes_mutated.clone()
	}
	var_valid_template_classes_mutated.array_push(rt.call_function('get_class', [
		rt.new_object('WC_Email_Customer_POS_Completed_Order', ['WC_Email'], &this),
	]))
	return var_valid_template_classes_mutated.clone()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) add_to_preferred_template_ids(var_preferred_template_ids rt.PhpVal, var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if !(this.is_applicable_for_order(var_order_mutated.clone())) {
		return var_preferred_template_ids.clone()
	}
	rt.call_function('array_unshift', [var_preferred_template_ids.clone(),
		rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
			'WC_Email',
		], &this), 'id')])
	return var_preferred_template_ids.clone()
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) is_applicable_for_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{}
	mut iife_result_3 := iife_temp_3.is_order_paid_at_pos(var_order_mutated.clone())
	return rt.is_true(iife_result_3)
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_OrderStatus.completed(), rt.call_method(var_order_mutated, 'get_status', [rt.new_string('edit')])))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_pos_store_name() rt.PhpVal {
	mut var_store_name := rt.call_function('get_option', [
		rt.new_string('woocommerce_pos_store_name'),
	])
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
	mut iife_result_4 := iife_temp_4.get_default_store_name()
	return this.format_string(if !rt.is_true(var_store_name) {
		iife_result_4
	} else {
		var_store_name
	})
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_pos_store_email() rt.PhpVal {
	mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
	mut iife_result_5 := iife_temp_5.get_default_store_email()
	return this.format_string(rt.call_function('get_option', [
		rt.new_string('woocommerce_pos_store_email'),
		iife_result_5,
	]))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_pos_store_phone_number() rt.PhpVal {
	return this.format_string(rt.call_function('get_option', [
		rt.new_string('woocommerce_pos_store_phone'),
	]))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_pos_store_address() rt.PhpVal {
	mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
	mut iife_result_6 := iife_temp_6.get_default_store_address()
	return this.format_string(rt.call_function('get_option', [
		rt.new_string('woocommerce_pos_store_address'),
		iife_result_6,
	]))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) get_pos_refund_returns_policy() rt.PhpVal {
	return this.format_string(rt.call_function('get_option', [
		rt.new_string('woocommerce_pos_refund_returns_policy'),
	]))
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) replace_footer_placeholders(var_footer_text rt.PhpVal, var_email rt.PhpVal) rt.PhpVal {
	mut var_footer_text_mutated := var_footer_text
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_email, 'id'), rt.get_property(rt.new_object('WC_Email_Customer_POS_Completed_Order', [
		'WC_Email',
	], &this), 'id')))))
	{
		return var_footer_text_mutated.clone()
	}
	if !(var_footer_text_mutated.clone().is_string()) {
		var_footer_text_mutated = rt.new_string((if rt.is_true(rt.call_function('is_scalar', [
			var_footer_text_mutated.clone(),
		]))
		{ var_footer_text_mutated.str() } else { '' }).str())
	}
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '{site_title}' },
			rt.ArrayItem{ key: none, val: '{store_address}' },
			rt.ArrayItem{ key: none, val: '{store_email}' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: this.get_pos_store_name() },
			rt.ArrayItem{ key: none, val: this.get_pos_store_address() },
			rt.ArrayItem{ key: none, val: this.get_pos_store_email() }]),
		var_footer_text_mutated.clone(),
	])
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	rt.PhpObjectBase
}

fn create_wc_email_customer_pos_completed_order() &Class_WC_Email_Customer_POS_Completed_Order {
	mut obj := &Class_WC_Email_Customer_POS_Completed_Order{
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

fn create_automattic_woocommerce_internal_orders_pointofsaleorderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{
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

fn create_automattic_woocommerce_internal_email_orderpriceformatter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter {
	mut obj := &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_settings_pointofsaledefaultsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.trigger(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_default_subject' {
			return this.get_default_subject()
		}
		'get_default_heading' {
			return this.get_default_heading()
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
		'auto_trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.auto_trigger(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'enable_order_email_actions_for_pos_orders' {
			this.enable_order_email_actions_for_pos_orders()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'add_pos_customizations' {
			this.add_pos_customizations()
			return rt.new_null()
		}
		'remove_pos_customizations' {
			this.remove_pos_customizations()
			return rt.new_null()
		}
		'email_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_header(dispatch_arg_0)
			return rt.new_null()
		}
		'email_footer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.email_footer(dispatch_arg_0)
			return rt.new_null()
		}
		'add_unit_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_unit_price(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'order_item_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.order_item_totals(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'enable_email_template_for_pos_orders' {
			this.enable_email_template_for_pos_orders()
			return rt.new_null()
		}
		'add_to_valid_template_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_to_valid_template_classes(dispatch_arg_0, dispatch_arg_1)
		}
		'add_to_preferred_template_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_to_preferred_template_ids(dispatch_arg_0, dispatch_arg_1)
		}
		'is_applicable_for_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_applicable_for_order(dispatch_arg_0))
		}
		'get_pos_store_name' {
			return this.get_pos_store_name()
		}
		'get_pos_store_email' {
			return this.get_pos_store_email()
		}
		'get_pos_store_phone_number' {
			return this.get_pos_store_phone_number()
		}
		'get_pos_store_address' {
			return this.get_pos_store_address()
		}
		'get_pos_refund_returns_policy' {
			return this.get_pos_refund_returns_policy()
		}
		'replace_footer_placeholders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.replace_footer_placeholders(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_POS_Completed_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_POS_Completed_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Email_OrderPriceFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('WC_Email_Customer_POS_Completed_Order'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_POS_Completed_Order', ['WC_Email'],
		create_wc_email_customer_pos_completed_order())
}
