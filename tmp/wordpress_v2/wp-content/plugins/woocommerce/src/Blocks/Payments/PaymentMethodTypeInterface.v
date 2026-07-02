import rt

interface PaymentMethodTypeInterface {
	is_active() rt.PhpVal
	get_payment_method_script_handles() rt.PhpVal
	get_payment_method_script_handles_for_admin() rt.PhpVal
	get_payment_method_data() rt.PhpVal
	get_supported_features() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}
