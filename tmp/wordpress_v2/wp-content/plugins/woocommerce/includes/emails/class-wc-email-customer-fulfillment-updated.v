import rt

struct Class_WC_Email_Customer_Fulfillment_Updated {
	rt.PhpObjectBase
pub mut:
	fulfillment   rt.PhpVal = rt.new_null()
	customer_note rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_fulfillment_updated'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Fulfillment updated'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-updates'))
	this.dispatch_set_prop('template_html',
		rt.new_string('emails/customer-fulfillment-updated.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-fulfillment-updated.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_fulfillment_updated_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(4),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Fulfillment updated emails are sent to the customer when the merchant updates a fulfillment for the order. The notification isn’t sent for draft fulfillments.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('template_block_content',
		rt.new_string('emails/block/general-block-content-for-fulfillment-emails.php'))
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) trigger(var_order_id rt.PhpVal, var_fulfillment rt.PhpVal, order bool, customer_note string) {
	mut order_mutated := order
	this.setup_locale()
	if rt.is_true(var_order_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).clone(), rt.new_string('WC_Order')]))))) {
		order_mutated = (rt.call_function('wc_get_order', [var_order_id.clone()])).to_bool()
	}
	if rt.is_true(rt.call_function('is_a', [rt.new_bool(order_mutated).clone(),
		rt.new_string('WC_Order')]))
	{
		this.dispatch_set_prop('object', rt.new_bool(order_mutated).clone())
		this.fulfillment = var_fulfillment.clone()
		this.customer_note = rt.new_string(customer_note)
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('A shipment from {site_title} order {order_number} has been updated'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Your shipment has been updated'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_content_html() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'template_html'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_content_plain() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'template_plain'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_block_editor_email_template_content() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
			'WC_Email',
		], &this), 'template_block_content'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'customer_note', val: this.customer_note },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Updated', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('If anything looks off or you have questions, feel free to contact our support team.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) maybe_init_fulfillment_for_preview(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_is_email_preview := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_preview'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_email_preview) {
		this.fulfillment = create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		rt.call_method(this.fulfillment, 'set_items', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{})]),
		])
		rt.call_method(this.fulfillment, 'add_meta_data', [
			rt.new_string('_tracking_number'),
			rt.new_string('123456789'),
		])
		rt.call_method(this.fulfillment, 'add_meta_data', [
			rt.new_string('_shipment_provider'),
			rt.new_string('dhl'),
		])
		rt.call_method(this.fulfillment, 'add_meta_data', [
			rt.new_string('_tracking_url'),
			rt.new_string('https://www.dhl.com/tracking/123456789'),
		])
		rt.call_method(this.fulfillment, 'add_meta_data', [rt.new_string('service'),
			rt.new_string('Standard Shipping')])
		rt.call_method(this.fulfillment, 'add_meta_data', [
			rt.new_string('expected_delivery'),
			rt.new_string('2025-06-30'),
		])
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_keys := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_keys.array_set('service', rt.call_function('__', [
				rt.new_string('Service'),
				rt.new_string('woocommerce'),
			]))
			var_keys.array_set('expected_delivery', rt.call_function('__', [
				rt.new_string('Expected Delivery'),
				rt.new_string('woocommerce'),
			]))
			return
		}
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_fulfillment_meta_key_translations'),
			rt.new_closure(closure_3_fn),
		])
		this.customer_note = rt.call_function('__', [
			rt.new_string('This is a sample note from the store. Your order has been updated with new tracking information.'),
			rt.new_string('woocommerce'),
		])
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

fn create_wc_email_customer_fulfillment_updated() &Class_WC_Email_Customer_Fulfillment_Updated {
	mut obj := &Class_WC_Email_Customer_Fulfillment_Updated{
		PhpObjectBase: rt.PhpObjectBase{}
		fulfillment:   rt.new_null()
		customer_note: rt.new_string('')
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			this.trigger(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
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
		'get_default_additional_content' {
			return this.get_default_additional_content()
		}
		'maybe_init_fulfillment_for_preview' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.maybe_init_fulfillment_for_preview(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Fulfillment_Updated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fulfillment' { return this.fulfillment }
		'customer_note' { return this.customer_note }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Updated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fulfillment' {
			this.fulfillment = val
			return true
		}
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

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		rt.new_string('WC_Email_Customer_Fulfillment_Updated'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_Fulfillment_Updated', ['WC_Email'],
		create_wc_email_customer_fulfillment_updated())
}
