import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	rt.PhpObjectBase
pub mut:
	email_template_generator rt.PhpVal = rt.new_null()
}

fn init_static_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemails() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails',
		'core_transactional_emails', rt.create_array([
		rt.ArrayItem{ key: none, val: 'admin_payment_gateway_enabled' },
		rt.ArrayItem{ key: none, val: 'cancelled_order' },
		rt.ArrayItem{ key: none, val: 'customer_cancelled_order' },
		rt.ArrayItem{ key: none, val: 'customer_completed_order' },
		rt.ArrayItem{ key: none, val: 'customer_failed_order' },
		rt.ArrayItem{ key: none, val: 'customer_invoice' },
		rt.ArrayItem{ key: none, val: 'customer_new_account' },
		rt.ArrayItem{ key: none, val: 'customer_note' },
		rt.ArrayItem{ key: none, val: 'customer_on_hold_order' },
		rt.ArrayItem{ key: none, val: 'customer_processing_order' },
		rt.ArrayItem{ key: none, val: 'customer_refunded_order' },
		rt.ArrayItem{ key: none, val: 'customer_partially_refunded_order' },
		rt.ArrayItem{ key: none, val: 'customer_reset_password' },
		rt.ArrayItem{ key: none, val: 'customer_review_request' },
		rt.ArrayItem{ key: none, val: 'failed_order' },
		rt.ArrayItem{ key: none, val: 'new_order' },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) construct() {
	this.email_template_generator =
		create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) init() {
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_email_templates' },
		]),
		rt.new_int(50)])
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.get_core_transactional_emails() rt.PhpVal {
	mut var_emails := rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails',
		'core_transactional_emails')
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 := iife_temp_0.feature_is_enabled(rt.new_string('point_of_sale'))
	if rt.is_true(iife_result_0) {
		var_emails.array_push('customer_pos_completed_order')
		var_emails.array_push('customer_pos_refunded_order')
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_1 := iife_temp_1.feature_is_enabled(rt.new_string('fulfillments'))
	if rt.is_true(iife_result_1) {
		mut var_fulfillment_emails := rt.create_array([
			rt.ArrayItem{ key: none, val: 'customer_fulfillment_created' },
			rt.ArrayItem{ key: none, val: 'customer_fulfillment_updated' },
			rt.ArrayItem{ key: none, val: 'customer_fulfillment_deleted' },
		])
		var_emails = rt.call_function('array_merge', [var_emails.clone(),
			var_fulfillment_emails.clone()])
	}
	return var_emails.clone()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.get_transactional_emails() rt.PhpVal {
	mut var_emails :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.get_core_transactional_emails()
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_transactional_emails_for_block_editor'),
		var_emails.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) init_email_templates() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_get_screen_ids'),
	])))))
	{
		return
	}
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_wc_screen_ids := rt.call_function('array_merge', [
		rt.call_function('wc_get_screen_ids', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_page_wc-admin' },
			rt.ArrayItem{ key: none, val: 'edit-woo_email' }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), var_wc_screen_ids.clone(), rt.new_bool(true)]))))) {
		return
	}
	rt.call_method(this.email_template_generator, 'initialize', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemails() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{
		PhpObjectBase:            rt.PhpObjectBase{}
		email_template_generator: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_core_transactional_emails' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.get_core_transactional_emails()
		}
		'get_transactional_emails' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails.get_transactional_emails()
		}
		'init_email_templates' {
			this.init_email_templates()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_template_generator' { return this.email_template_generator }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_template_generator' {
			this.email_template_generator = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
