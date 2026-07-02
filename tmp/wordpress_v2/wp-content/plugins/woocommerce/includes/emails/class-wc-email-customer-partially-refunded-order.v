import rt

struct Class_WC_Email_Customer_Partially_Refunded_Order {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) construct() {
	this.Class_WC_Email_Customer_Refunded_Order.construct()
	this.dispatch_set_prop('id', rt.new_string('customer_partially_refunded_order'))
	this.dispatch_set_prop('title', rt.call_function('__', [
		rt.new_string('Partially refunded order'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('description', rt.call_function('__', [
		rt.new_string('Notifies customers when their order has been partially refunded.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('partial_refund', rt.new_bool(true))
	this.dispatch_set_prop('template_block',
		rt.new_string('emails/block/customer-partially-refunded-order.php'))
	rt.call_function('remove_action', [
		rt.new_string('woocommerce_order_fully_refunded_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger_full' },
		]),
		rt.new_int(10),
	])
	rt.call_function('remove_action', [
		rt.new_string('woocommerce_order_partially_refunded_notification'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this) },
			rt.ArrayItem{ key: none, val: 'trigger_partial' },
		]),
		rt.new_int(10),
	])
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) get_block_editor_email_template_content() rt.PhpVal {
	return rt.call_function('wc_get_template_html', [
		rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
			'WC_Email_Customer_Refunded_Order',
		], &this), 'template_block_content'),
		rt.create_array([
			rt.ArrayItem{ key: 'order', val: rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this), 'object') },
			rt.ArrayItem{ key: 'refund', val: rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this), 'refund') },
			rt.ArrayItem{ key: 'partial_refund', val: rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this), 'partial_refund') },
			rt.ArrayItem{ key: 'sent_to_admin', val: false },
			rt.ArrayItem{ key: 'plain_text', val: false },
			rt.ArrayItem{ key: 'email', val: rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this) },
		]),
	])
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) get_subject() rt.PhpVal {
	mut var_subject := this.get_option(rt.new_string('subject_partial'),
		this.get_default_subject(rt.new_bool(true)))
	var_subject = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_subject_customer_refunded_order'),
		this.format_string(var_subject.clone()),
		rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
			'WC_Email_Customer_Refunded_Order',
		], &this), 'object'),
		rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
			'WC_Email_Customer_Refunded_Order',
		], &this),
	])
	if rt.is_true(rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
		'WC_Email_Customer_Refunded_Order',
	], &this), 'block_email_editor_enabled'))
	{
		var_subject = rt.call_method(rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
			'WC_Email_Customer_Refunded_Order',
		], &this), 'personalizer'), 'personalize_transactional_content', [
			var_subject.clone(),
			rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
				'WC_Email_Customer_Refunded_Order',
			], &this)])
	}
	return var_subject.clone()
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) get_option_key() string {
	mut var_id := rt.new_string('customer_refunded_order')
	return
		(rt.get_property(rt.new_object('WC_Email_Customer_Partially_Refunded_Order', ['WC_Email_Customer_Refunded_Order'], &this), 'plugin_id')).str() +
		var_id.str() + '_settings'
}

struct Class_WC_Email_Customer_Refunded_Order {
	rt.PhpObjectBase
}

fn create_wc_email_customer_partially_refunded_order() &Class_WC_Email_Customer_Partially_Refunded_Order {
	mut obj := &Class_WC_Email_Customer_Partially_Refunded_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_email_customer_refunded_order(_args ...rt.PhpVal) &Class_WC_Email_Customer_Refunded_Order {
	mut obj := &Class_WC_Email_Customer_Refunded_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_block_editor_email_template_content' {
			return this.get_block_editor_email_template_content()
		}
		'get_subject' {
			return this.get_subject()
		}
		'get_option_key' {
			return rt.new_string(this.get_option_key())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Email_Customer_Partially_Refunded_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_Partially_Refunded_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Email_Customer_Refunded_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Email_Customer_Refunded_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.include_file(@DIR + '/class-wc-email-customer-refunded-order.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Email_Customer_Partially_Refunded_Order'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Email_Customer_Partially_Refunded_Order', [
		'WC_Email_Customer_Refunded_Order',
	], create_wc_email_customer_partially_refunded_order())
}
