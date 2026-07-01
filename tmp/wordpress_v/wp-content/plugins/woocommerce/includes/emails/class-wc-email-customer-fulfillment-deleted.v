import rt

struct Class_WC_Email_Customer_Fulfillment_Deleted {
	rt.PhpObjectBase
pub mut:
	fulfillment rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) construct() {
	this.dispatch_set_prop('id', rt.new_string('customer_fulfillment_deleted'))
	this.dispatch_set_prop('customer_email', rt.new_bool(true))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Fulfillment deleted'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('email_group', rt.new_string('order-updates'))
	this.dispatch_set_prop('template_html',
		rt.new_string('emails/customer-fulfillment-deleted.php'))
	this.dispatch_set_prop('template_plain',
		rt.new_string('emails/plain/customer-fulfillment-deleted.php'))
	this.dispatch_set_prop('placeholders', rt.create_array([
		rt.ArrayItem{ key: '{order_date}', val: '' },
		rt.ArrayItem{ key: '{order_number}', val: '' },
	]))
	rt.call_function('add_action', [
		rt.new_string('woocommerce_fulfillment_deleted_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	this.Class_WC_Email.construct()
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Fulfillment deleted emails are sent to the customer when the merchant cancels an already fulfilled fulfillment. The notification isn’t sent for draft fulfillments.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('template_block_content',
		rt.new_string('emails/block/general-block-content-for-fulfillment-emails.php'))
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) trigger(var_order_id rt.PhpVal, var_fulfillment rt.PhpVal, order bool) {
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
		this.fulfillment = var_fulfillment.dup()
		this.dispatch_set_prop('recipient', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'object'), 'get_billing_email', []rt.PhpVal{}))
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_date}', rt.call_function('wc_format_datetime', [
			rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this), 'object'), 'get_date_created', []rt.PhpVal{}),
		]))
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'placeholders').array_set('{order_number}', rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'object'), 'get_order_number', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(this.is_enabled()) && rt.is_true(this.get_recipient()))) {
		this.send(this.get_recipient(), this.get_subject(), this.get_content(), this.get_headers(),
			this.get_attachments())
	}
	this.restore_locale()
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_default_subject() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('A shipment from {site_title} order {order_number} has been cancelled'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_default_heading() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('One of your shipments has been removed'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_content_html() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'template_html'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_content_plain() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'template_plain'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'email_heading', val: this.get_heading() },
			rt.ArrayItem{ key: 'additional_content', val: this.get_additional_content() },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: true },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_block_editor_email_template_content() rt.PhpVal {
	this.maybe_init_fulfillment_for_preview(rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
		'WC_Email',
	], &this), 'object'))
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
			'WC_Email',
		], &this), 'template_block_content'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this), 'object') },
			rt.ArrayItem{ key: 'fulfillment', val: this.fulfillment },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Fulfillment_Deleted', [
				'WC_Email',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) get_default_additional_content() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('If you have any questions or notice anything unexpected, feel free to reach out to our support team through your account or reply to this email.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) maybe_init_fulfillment_for_preview(var_order rt.PhpVal) {
	mut var_order_mutated := var_order
	mut var_is_email_preview := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_is_email_preview'),
		rt.new_bool(false),
	])
	if rt.is_true(var_is_email_preview) {
		this.fulfillment = create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return rt.create_array([
					rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id',
						[]rt.PhpVal{}) },
					rt.ArrayItem{ key: 'qty', val: 1 },
				])
			}
			mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.create_array([
				rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'qty', val: 1 },
			])
		}
		rt.call_method(this.fulfillment, 'set_items', [
			rt.call_function('array_map', [rt.new_closure(closure_1_fn),
				rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{})]),
		])
		rt.call_method(this.fulfillment, 'set_date_deleted', [
			rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s')]),
		])
	}
}

struct Class_WC_Email {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

fn create_wc_email_customer_fulfillment_deleted() &Class_WC_Email_Customer_Fulfillment_Deleted {
	mut obj := &Class_WC_Email_Customer_Fulfillment_Deleted{
		PhpObjectBase: rt.PhpObjectBase{}
		fulfillment:   rt.new_null()
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

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'trigger' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.trigger(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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

fn (this &Class_WC_Email_Customer_Fulfillment_Deleted) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fulfillment' { return this.fulfillment }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Email_Customer_Fulfillment_Deleted) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fulfillment' {
			this.fulfillment = val
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

pub fn init_wp_content_plugins_woocommerce_includes_emails_class_wc_email_customer_fulfillment_deleted_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Fulfillment_Deleted'),
		rt.new_bool(false),
	])))))
	{
	}
	return create_wc_email_customer_fulfillment_deleted()
}
