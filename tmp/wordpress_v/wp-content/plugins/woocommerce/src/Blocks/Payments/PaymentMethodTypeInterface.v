import rt

interface PaymentMethodTypeInterface {
	is_active() rt.PhpVal
	get_payment_method_script_handles() rt.PhpVal
	get_payment_method_script_handles_for_admin() rt.PhpVal
	get_payment_method_data() rt.PhpVal
	get_supported_features() rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_payments_paymentmethodtypeinterface_php() {
}
