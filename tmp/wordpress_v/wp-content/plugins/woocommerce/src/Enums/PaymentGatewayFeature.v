import rt

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.add_payment_method() string {
	return 'add_payment_method'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.credit_card_form_cvc_on_saved_method() string {
	return 'credit_card_form_cvc_on_saved_method'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.default_credit_card_form() string {
	return 'default_credit_card_form'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.deposits() string {
	return 'deposits'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.multiple_subscriptions() string {
	return 'multiple_subscriptions'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.pay_button() string {
	return 'pay_button'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.pre_orders() string {
	return 'pre-orders'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.products() string {
	return 'products'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds() string {
	return 'refunds'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_amount_changes() string {
	return 'subscription_amount_changes'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_cancellation() string {
	return 'subscription_cancellation'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_date_changes() string {
	return 'subscription_date_changes'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change() string {
	return 'subscription_payment_method_change'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change_admin() string {
	return 'subscription_payment_method_change_admin'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_payment_method_change_customer() string {
	return 'subscription_payment_method_change_customer'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_reactivation() string {
	return 'subscription_reactivation'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscription_suspension() string {
	return 'subscription_suspension'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.subscriptions() string {
	return 'subscriptions'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization() string {
	return 'tokenization'
}

pub fn Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.agentic_commerce() string {
	return 'agentic_commerce'
}

struct Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_paymentgatewayfeature() &Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature {
	mut obj := &Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_enums_paymentgatewayfeature_php() {
	// unsupported statement: Stmt_Declare
}
