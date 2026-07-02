import rt

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways',
		'recommendation_priority', rt.create_array([
		rt.ArrayItem{ key: 'woocommerce_payments', val: 1 },
		rt.ArrayItem{ key: 'woocommerce_payments:with-in-person-payments', val: 1 },
		rt.ArrayItem{ key: 'woocommerce_payments:without-in-person-payments', val: 1 },
		rt.ArrayItem{ key: 'stripe', val: 2 },
		rt.ArrayItem{ key: 'woo-mercado-pago-custom', val: 3 },
		rt.ArrayItem{ key: 'ppcp-gateway', val: 4 },
		rt.ArrayItem{ key: 'mollie_wc_gateway_banktransfer', val: 5 },
		rt.ArrayItem{ key: 'razorpay', val: 5 },
		rt.ArrayItem{ key: 'payfast', val: 5 },
		rt.ArrayItem{ key: 'payubiz', val: 6 },
		rt.ArrayItem{ key: 'square_credit_card', val: 6 },
		rt.ArrayItem{ key: 'klarna_payments', val: 6 },
		rt.ArrayItem{ key: 'kco', val: 6 },
		rt.ArrayItem{ key: 'paystack', val: 6 },
		rt.ArrayItem{ key: 'eway', val: 7 },
		rt.ArrayItem{ key: 'amazon_payments_advanced', val: 7 },
		rt.ArrayItem{ key: 'affirm', val: 8 },
		rt.ArrayItem{ key: 'afterpay', val: 9 },
		rt.ArrayItem{ key: 'zipmoney', val: 10 },
		rt.ArrayItem{ key: 'payoneer-checkout', val: 11 },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_all() rt.PhpVal {
	mut var_payment_gateways := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'affirm' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Affirm'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Affirm’s tailored Buy Now Pay Later programs remove price as a barrier, turning browsers into buyers, increasing average order value, and expanding your customer base.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'image'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/affirm.png'
			},
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/affirm.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.new_array() },
			rt.ArrayItem{
				key: 'external_link'
				val: 'https://woocommerce.com/products/woocommerce-gateway-affirm'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(rt.new_bool(false))
						},
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(rt.new_bool(false))
						},
					]) },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'afterpay' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Afterpay'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Afterpay allows customers to receive products immediately and pay for purchases over four installments, always interest-free.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'image'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/afterpay.png'
			},
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/afterpay.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'afterpay-gateway-for-woocommerce' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
					rt.ArrayItem{ key: none, val: 'AU' },
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.create_array([
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(rt.new_bool(false))
						},
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(rt.new_bool(false))
						},
					]) },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'AU' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'airwallex_main' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Airwallex Payments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Boost international sales and save on FX fees. Accept 60+ local payment methods including Apple Pay and Google Pay.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/airwallex.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/airwallex.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'airwallex-online-payments-gateway' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'EE' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GR' },
					rt.ArrayItem{ key: none, val: 'IE' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'PL' },
					rt.ArrayItem{ key: none, val: 'PT' },
					rt.ArrayItem{ key: none, val: 'AU' },
					rt.ArrayItem{ key: none, val: 'NZ' },
					rt.ArrayItem{ key: none, val: 'HK' },
					rt.ArrayItem{ key: none, val: 'SG' },
					rt.ArrayItem{ key: none, val: 'CN' },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'EE' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GR' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'PL' },
				rt.ArrayItem{ key: none, val: 'PT' },
				rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'CN' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'amazon_payments_advanced' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Amazon Pay'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Enable a familiar, fast checkout for hundreds of millions of active Amazon customers globally.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'image'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/amazonpay.png'
			},
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/amazonpay.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-gateway-amazon-payments-advanced' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'CY' },
					rt.ArrayItem{ key: none, val: 'DK' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'HU' },
					rt.ArrayItem{ key: none, val: 'IE' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'LU' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'PT' },
					rt.ArrayItem{ key: none, val: 'SL' },
					rt.ArrayItem{ key: none, val: 'SE' },
					rt.ArrayItem{ key: none, val: 'JP' },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'CY' },
				rt.ArrayItem{ key: none, val: 'DK' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'HU' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'LU' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'PT' },
				rt.ArrayItem{ key: none, val: 'SL' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'JP' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: Class_WC_Gateway_BACS.id() },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Direct bank transfer'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Take payments via bank transfer.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/bacs.svg' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/bacs.png'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'is_offline', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: Class_WC_Gateway_COD.id() },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Cash on delivery'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Take payments in cash upon delivery.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/cod.svg' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/cod.png'
			},
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'is_offline', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'eway' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Eway'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('The Eway extension for WooCommerce allows you to take credit card payments directly on your store without redirecting your customers to a third party site to make payment.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/eway.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/eway.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-gateway-eway' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: false },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'kco' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Klarna Checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Choose the payment that you want, pay now, pay later or slice it. No credit card numbers, no passwords, no worries.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/klarna-black.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/klarna.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'klarna-checkout-for-woocommerce' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'NO' },
					rt.ArrayItem{ key: none, val: 'SE' },
					rt.ArrayItem{ key: none, val: 'FI' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'NO' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'FI' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'klarna_payments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Klarna Payments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Choose the payment that you want, pay now, pay later or slice it. No credit card numbers, no passwords, no worries.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/klarna-black.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/klarna.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'klarna-payments-for-woocommerce' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'MX' },
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'CH' },
					rt.ArrayItem{ key: none, val: 'DK' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'FI' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'NO' },
					rt.ArrayItem{ key: none, val: 'PL' },
					rt.ArrayItem{ key: none, val: 'SE' },
					rt.ArrayItem{ key: none, val: 'NZ' },
					rt.ArrayItem{ key: none, val: 'AU' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'not' },
							rt.ArrayItem{ key: 'operand', val: rt.create_array([
								rt.ArrayItem{
									key: none
									val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries())
								},
							]) },
						])) },
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(rt.new_bool(false))
						},
						rt.ArrayItem{
							key: none
							val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(rt.new_bool(false))
						},
					]) },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'CH' },
				rt.ArrayItem{ key: none, val: 'DK' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FI' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'NO' },
				rt.ArrayItem{ key: none, val: 'PL' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'AU' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Mollie'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Effortless payments by Mollie: Offer global and local payment methods, get onboarded in minutes, and supported in your language.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/mollie.svg' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/mollie.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'mollie-payments-for-woocommerce' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'CH' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'FI' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'PL' },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'CH' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FI' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'PL' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'payfast' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Payfast'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('The Payfast extension for WooCommerce enables you to accept payments by Credit Card and EFT via one of South Africa’s most popular payment gateways. No setup fees or monthly subscription costs. Selecting this extension will configure your store to use South African rands as the selected currency.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payfast.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/payfast.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payfast-gateway' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'ZA' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'ZA' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'payoneer-checkout' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Payoneer Checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Payoneer Checkout is the next generation of payment processing platforms, giving merchants around the world the solutions and direction they need to succeed in today’s hyper-competitive global market.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/payoneer.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/payoneer.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'payoneer-checkout' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'HK' },
					rt.ArrayItem{ key: none, val: 'CN' },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'CN' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'paystack' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Paystack'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Paystack helps African merchants accept one-time and recurring payments online with a modern, safe, and secure payment gateway.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/paystack.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/paystack.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woo-paystack' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'ZA' },
					rt.ArrayItem{ key: none, val: 'GH' },
					rt.ArrayItem{ key: none, val: 'NG' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'ZA' },
				rt.ArrayItem{ key: none, val: 'GH' },
				rt.ArrayItem{ key: none, val: 'NG' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'payubiz' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('PayU for WooCommerce'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Enable PayU’s exclusive plugin for WooCommerce to start accepting payments in 100+ payment methods available in India including credit cards, debit cards, UPI, & more!'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/payu.svg' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/payu.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'payu-india' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'base_location_country' },
					rt.ArrayItem{ key: 'value', val: 'IN' },
					rt.ArrayItem{ key: 'operation', val: '=' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'IN' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'ppcp-gateway' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('PayPal Payments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string("Safe and secure payments using credit cards or your customer's PayPal account."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/paypal.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/paypal.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-paypal-payments' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
					rt.ArrayItem{ key: none, val: 'MX' },
					rt.ArrayItem{ key: none, val: 'BR' },
					rt.ArrayItem{ key: none, val: 'AR' },
					rt.ArrayItem{ key: none, val: 'CL' },
					rt.ArrayItem{ key: none, val: 'CO' },
					rt.ArrayItem{ key: none, val: 'EC' },
					rt.ArrayItem{ key: none, val: 'PE' },
					rt.ArrayItem{ key: none, val: 'UY' },
					rt.ArrayItem{ key: none, val: 'VE' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'BG' },
					rt.ArrayItem{ key: none, val: 'HR' },
					rt.ArrayItem{ key: none, val: 'CH' },
					rt.ArrayItem{ key: none, val: 'CY' },
					rt.ArrayItem{ key: none, val: 'CZ' },
					rt.ArrayItem{ key: none, val: 'DK' },
					rt.ArrayItem{ key: none, val: 'EE' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'FI' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'GR' },
					rt.ArrayItem{ key: none, val: 'HU' },
					rt.ArrayItem{ key: none, val: 'IE' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'LV' },
					rt.ArrayItem{ key: none, val: 'LT' },
					rt.ArrayItem{ key: none, val: 'LU' },
					rt.ArrayItem{ key: none, val: 'MT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'NO' },
					rt.ArrayItem{ key: none, val: 'PL' },
					rt.ArrayItem{ key: none, val: 'PT' },
					rt.ArrayItem{ key: none, val: 'RO' },
					rt.ArrayItem{ key: none, val: 'SK' },
					rt.ArrayItem{ key: none, val: 'SL' },
					rt.ArrayItem{ key: none, val: 'SE' },
					rt.ArrayItem{ key: none, val: 'AU' },
					rt.ArrayItem{ key: none, val: 'NZ' },
					rt.ArrayItem{ key: none, val: 'HK' },
					rt.ArrayItem{ key: none, val: 'JP' },
					rt.ArrayItem{ key: none, val: 'SG' },
					rt.ArrayItem{ key: none, val: 'CN' },
					rt.ArrayItem{ key: none, val: 'ID' },
					rt.ArrayItem{ key: none, val: 'IN' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'BR' },
				rt.ArrayItem{ key: none, val: 'AR' },
				rt.ArrayItem{ key: none, val: 'CL' },
				rt.ArrayItem{ key: none, val: 'CO' },
				rt.ArrayItem{ key: none, val: 'EC' },
				rt.ArrayItem{ key: none, val: 'PE' },
				rt.ArrayItem{ key: none, val: 'UY' },
				rt.ArrayItem{ key: none, val: 'VE' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'BG' },
				rt.ArrayItem{ key: none, val: 'HR' },
				rt.ArrayItem{ key: none, val: 'CH' },
				rt.ArrayItem{ key: none, val: 'CY' },
				rt.ArrayItem{ key: none, val: 'CZ' },
				rt.ArrayItem{ key: none, val: 'DK' },
				rt.ArrayItem{ key: none, val: 'EE' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FI' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'GR' },
				rt.ArrayItem{ key: none, val: 'HU' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'LV' },
				rt.ArrayItem{ key: none, val: 'LT' },
				rt.ArrayItem{ key: none, val: 'LU' },
				rt.ArrayItem{ key: none, val: 'MT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'NO' },
				rt.ArrayItem{ key: none, val: 'PL' },
				rt.ArrayItem{ key: none, val: 'PT' },
				rt.ArrayItem{ key: none, val: 'RO' },
				rt.ArrayItem{ key: none, val: 'SK' },
				rt.ArrayItem{ key: none, val: 'SL' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'JP' },
				rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'CN' },
				rt.ArrayItem{ key: none, val: 'ID' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'ZA' },
				rt.ArrayItem{ key: none, val: 'NG' },
				rt.ArrayItem{ key: none, val: 'GH' },
				rt.ArrayItem{ key: none, val: 'EC' },
				rt.ArrayItem{ key: none, val: 'VE' },
				rt.ArrayItem{ key: none, val: 'AR' },
				rt.ArrayItem{ key: none, val: 'CL' },
				rt.ArrayItem{ key: none, val: 'CO' },
				rt.ArrayItem{ key: none, val: 'PE' },
				rt.ArrayItem{ key: none, val: 'UY' },
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'BR' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'BG' },
				rt.ArrayItem{ key: none, val: 'HR' },
				rt.ArrayItem{ key: none, val: 'CH' },
				rt.ArrayItem{ key: none, val: 'CY' },
				rt.ArrayItem{ key: none, val: 'CZ' },
				rt.ArrayItem{ key: none, val: 'DK' },
				rt.ArrayItem{ key: none, val: 'EE' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FI' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'GR' },
				rt.ArrayItem{ key: none, val: 'HU' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'LV' },
				rt.ArrayItem{ key: none, val: 'LT' },
				rt.ArrayItem{ key: none, val: 'LU' },
				rt.ArrayItem{ key: none, val: 'MT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'NO' },
				rt.ArrayItem{ key: none, val: 'PL' },
				rt.ArrayItem{ key: none, val: 'PT' },
				rt.ArrayItem{ key: none, val: 'RO' },
				rt.ArrayItem{ key: none, val: 'SK' },
				rt.ArrayItem{ key: none, val: 'SL' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'JP' },
				rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'CN' },
				rt.ArrayItem{ key: none, val: 'ID' },
				rt.ArrayItem{ key: none, val: 'IN' },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'razorpay' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Razorpay'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('The official Razorpay extension for WooCommerce allows you to accept credit cards, debit cards, netbanking, wallet, and UPI payments.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/razorpay.svg' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/razorpay.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woo-razorpay' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'base_location_country' },
					rt.ArrayItem{ key: 'value', val: 'IN' },
					rt.ArrayItem{ key: 'operation', val: '=' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'IN' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'square_credit_card' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Square'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Securely accept credit and debit cards with one low rate, no surprise fees (custom rates available). Sell online and in store and track sales and inventory in one place.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/square-black.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/square.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-square' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
								rt.ArrayItem{ key: none, val: 'US' },
							])) },
							rt.ArrayItem{
								key: none
								val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(true))
							},
						]) },
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
								rt.ArrayItem{ key: none, val: 'US' },
								rt.ArrayItem{ key: none, val: 'CA' },
								rt.ArrayItem{ key: none, val: 'IE' },
								rt.ArrayItem{ key: none, val: 'ES' },
								rt.ArrayItem{ key: none, val: 'FR' },
								rt.ArrayItem{ key: none, val: 'GB' },
								rt.ArrayItem{ key: none, val: 'AU' },
								rt.ArrayItem{ key: none, val: 'JP' },
							])) },
							rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
								rt.ArrayItem{ key: 'type', val: 'or' },
								rt.ArrayItem{ key: 'operands', val: rt.array_to_object(rt.create_array([
									rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_selling_venues(rt.create_array([
										rt.ArrayItem{ key: none, val: 'brick-mortar' },
										rt.ArrayItem{ key: none, val: 'brick-mortar-other' },
									])) },
									rt.ArrayItem{
										key: none
										val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_selling_offline()
									},
								])) },
							])) },
						]) },
					])) },
				])) },
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'JP' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'stripe' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string(' Stripe'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Accept debit and credit cards in 135+ currencies, methods such as Alipay, and one-touch checkout with Apple Pay.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/stripe.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/stripe.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-gateway-stripe' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
					rt.ArrayItem{ key: none, val: 'MX' },
					rt.ArrayItem{ key: none, val: 'BR' },
					rt.ArrayItem{ key: none, val: 'AT' },
					rt.ArrayItem{ key: none, val: 'BE' },
					rt.ArrayItem{ key: none, val: 'BG' },
					rt.ArrayItem{ key: none, val: 'CH' },
					rt.ArrayItem{ key: none, val: 'CY' },
					rt.ArrayItem{ key: none, val: 'CZ' },
					rt.ArrayItem{ key: none, val: 'DK' },
					rt.ArrayItem{ key: none, val: 'EE' },
					rt.ArrayItem{ key: none, val: 'ES' },
					rt.ArrayItem{ key: none, val: 'FI' },
					rt.ArrayItem{ key: none, val: 'FR' },
					rt.ArrayItem{ key: none, val: 'DE' },
					rt.ArrayItem{ key: none, val: 'GB' },
					rt.ArrayItem{ key: none, val: 'GR' },
					rt.ArrayItem{ key: none, val: 'HU' },
					rt.ArrayItem{ key: none, val: 'IE' },
					rt.ArrayItem{ key: none, val: 'IT' },
					rt.ArrayItem{ key: none, val: 'LV' },
					rt.ArrayItem{ key: none, val: 'LT' },
					rt.ArrayItem{ key: none, val: 'LU' },
					rt.ArrayItem{ key: none, val: 'MT' },
					rt.ArrayItem{ key: none, val: 'NL' },
					rt.ArrayItem{ key: none, val: 'NO' },
					rt.ArrayItem{ key: none, val: 'PL' },
					rt.ArrayItem{ key: none, val: 'PT' },
					rt.ArrayItem{ key: none, val: 'RO' },
					rt.ArrayItem{ key: none, val: 'SK' },
					rt.ArrayItem{ key: none, val: 'SL' },
					rt.ArrayItem{ key: none, val: 'SE' },
					rt.ArrayItem{ key: none, val: 'AU' },
					rt.ArrayItem{ key: none, val: 'NZ' },
					rt.ArrayItem{ key: none, val: 'HK' },
					rt.ArrayItem{ key: none, val: 'JP' },
					rt.ArrayItem{ key: none, val: 'SG' },
					rt.ArrayItem{ key: none, val: 'ID' },
					rt.ArrayItem{ key: none, val: 'IN' },
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
			]) },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'US' },
				rt.ArrayItem{ key: none, val: 'CA' },
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'BR' },
				rt.ArrayItem{ key: none, val: 'AT' },
				rt.ArrayItem{ key: none, val: 'BE' },
				rt.ArrayItem{ key: none, val: 'BG' },
				rt.ArrayItem{ key: none, val: 'CH' },
				rt.ArrayItem{ key: none, val: 'CY' },
				rt.ArrayItem{ key: none, val: 'CZ' },
				rt.ArrayItem{ key: none, val: 'DK' },
				rt.ArrayItem{ key: none, val: 'EE' },
				rt.ArrayItem{ key: none, val: 'ES' },
				rt.ArrayItem{ key: none, val: 'FI' },
				rt.ArrayItem{ key: none, val: 'FR' },
				rt.ArrayItem{ key: none, val: 'DE' },
				rt.ArrayItem{ key: none, val: 'GB' },
				rt.ArrayItem{ key: none, val: 'GR' },
				rt.ArrayItem{ key: none, val: 'HU' },
				rt.ArrayItem{ key: none, val: 'IE' },
				rt.ArrayItem{ key: none, val: 'IT' },
				rt.ArrayItem{ key: none, val: 'LV' },
				rt.ArrayItem{ key: none, val: 'LT' },
				rt.ArrayItem{ key: none, val: 'LU' },
				rt.ArrayItem{ key: none, val: 'MT' },
				rt.ArrayItem{ key: none, val: 'NL' },
				rt.ArrayItem{ key: none, val: 'NO' },
				rt.ArrayItem{ key: none, val: 'PL' },
				rt.ArrayItem{ key: none, val: 'PT' },
				rt.ArrayItem{ key: none, val: 'RO' },
				rt.ArrayItem{ key: none, val: 'SK' },
				rt.ArrayItem{ key: none, val: 'SL' },
				rt.ArrayItem{ key: none, val: 'SE' },
				rt.ArrayItem{ key: none, val: 'AU' },
				rt.ArrayItem{ key: none, val: 'NZ' },
				rt.ArrayItem{ key: none, val: 'HK' },
				rt.ArrayItem{ key: none, val: 'JP' },
				rt.ArrayItem{ key: none, val: 'SG' },
				rt.ArrayItem{ key: none, val: 'ID' },
				rt.ArrayItem{ key: none, val: 'IN' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Mercado Pago'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Set up your payment methods and accept credit and debit cards, cash, bank transfers and money from your Mercado Pago account. Offer safe and secure payments with Latin America’s leading processor.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'image'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/mercadopago.png'
			},
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/mercadopago.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-mercadopago' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'AR' },
					rt.ArrayItem{ key: none, val: 'CL' },
					rt.ArrayItem{ key: none, val: 'CO' },
					rt.ArrayItem{ key: none, val: 'EC' },
					rt.ArrayItem{ key: none, val: 'PE' },
					rt.ArrayItem{ key: none, val: 'UY' },
					rt.ArrayItem{ key: none, val: 'MX' },
					rt.ArrayItem{ key: none, val: 'BR' },
				])) },
			]) },
			rt.ArrayItem{ key: 'is_local_partner', val: true },
			rt.ArrayItem{ key: 'category_other', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'AR' },
				rt.ArrayItem{ key: none, val: 'CL' },
				rt.ArrayItem{ key: none, val: 'CO' },
				rt.ArrayItem{ key: none, val: 'EC' },
				rt.ArrayItem{ key: none, val: 'PE' },
				rt.ArrayItem{ key: none, val: 'UY' },
				rt.ArrayItem{ key: none, val: 'MX' },
				rt.ArrayItem{ key: none, val: 'BR' },
			]) },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Manage transactions without leaving your WordPress Dashboard. Only with WooPayments.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'image_72x72', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('With WooPayments, you can securely accept major cards, Apple Pay, and payments in over 100 currencies. Track cash flow and manage recurring revenue directly from your store’s dashboard - with no setup costs or monthly fees.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries())
				},
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'plugin_version' },
					rt.ArrayItem{ key: 'plugin', val: 'woocommerce' },
					rt.ArrayItem{ key: 'version', val: '5.10.0-dev' },
					rt.ArrayItem{ key: 'operator', val: '<' },
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'not' },
							rt.ArrayItem{ key: 'operand', val: rt.create_array([
								rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
									rt.ArrayItem{ key: 'type', val: 'plugins_activated' },
									rt.ArrayItem{ key: 'plugins', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'woocommerce-admin' },
									]) },
								])) },
							]) },
						])) },
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugin_version' },
							rt.ArrayItem{ key: 'plugin', val: 'woocommerce-admin' },
							rt.ArrayItem{ key: 'version', val: '2.9.0-dev' },
							rt.ArrayItem{ key: 'operator', val: '<' },
						])) },
					])) },
				])) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Manage transactions without leaving your WordPress Dashboard. Only with WooPayments.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'image_72x72', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('With WooPayments, you can securely accept major cards, Apple Pay, and payments in over 100 currencies. Track cash flow and manage recurring revenue directly from your store’s dashboard - with no setup costs or monthly fees.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.call_function('array_diff', [
					Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries(),
					rt.create_array([
						rt.ArrayItem{ key: none, val: 'US' },
						rt.ArrayItem{ key: none, val: 'CA' },
					]),
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugin_version' },
							rt.ArrayItem{ key: 'plugin', val: 'woocommerce-admin' },
							rt.ArrayItem{ key: 'version', val: '2.9.0-dev' },
							rt.ArrayItem{ key: 'operator', val: '>=' },
						])) },
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugin_version' },
							rt.ArrayItem{ key: 'plugin', val: 'woocommerce' },
							rt.ArrayItem{ key: 'version', val: '5.10.0-dev' },
							rt.ArrayItem{ key: 'operator', val: '>=' },
						])) },
					])) },
				])) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Manage transactions without leaving your WordPress Dashboard. Only with WooPayments.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'image_72x72', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay.svg' },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('With WooPayments, you can securely accept major cards, Apple Pay, and payments in over 100 currencies – with no setup costs or monthly fees – and you can now accept in-person payments with the Woo mobile app.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.create_array([
					rt.ArrayItem{ key: none, val: 'US' },
					rt.ArrayItem{ key: none, val: 'CA' },
				])) },
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'or' },
					rt.ArrayItem{ key: 'operands', val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugin_version' },
							rt.ArrayItem{ key: 'plugin', val: 'woocommerce-admin' },
							rt.ArrayItem{ key: 'version', val: '2.9.0-dev' },
							rt.ArrayItem{ key: 'operator', val: '>=' },
						])) },
						rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'plugin_version' },
							rt.ArrayItem{ key: 'plugin', val: 'woocommerce' },
							rt.ArrayItem{ key: 'version', val: '5.10.0-dev' },
							rt.ArrayItem{ key: 'operator', val: '>=' },
						])) },
					])) },
				])) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments:bnpl' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Activate BNPL instantly on WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('The world’s favorite buy now, pay later options and many more are right at your fingertips with WooPayments — all from one dashboard, without needing multiple extensions and logins.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay-bnpl.svg' },
			rt.ArrayItem{ key: 'image_72x72', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/wcpay-bnpl.svg' },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(rt.call_function('array_intersect', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: 'US' },
						rt.ArrayItem{ key: none, val: 'CA' },
						rt.ArrayItem{ key: none, val: 'AU' },
						rt.ArrayItem{ key: none, val: 'AT' },
						rt.ArrayItem{ key: none, val: 'BE' },
						rt.ArrayItem{ key: none, val: 'CH' },
						rt.ArrayItem{ key: none, val: 'DK' },
						rt.ArrayItem{ key: none, val: 'ES' },
						rt.ArrayItem{ key: none, val: 'FI' },
						rt.ArrayItem{ key: none, val: 'FR' },
						rt.ArrayItem{ key: none, val: 'DE' },
						rt.ArrayItem{ key: none, val: 'GB' },
						rt.ArrayItem{ key: none, val: 'IT' },
						rt.ArrayItem{ key: none, val: 'NL' },
						rt.ArrayItem{ key: none, val: 'NO' },
						rt.ArrayItem{ key: none, val: 'PL' },
						rt.ArrayItem{ key: none, val: 'SE' },
						rt.ArrayItem{ key: none, val: 'NZ' },
					]),
					Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries(),
				])) },
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(rt.new_bool(false))
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(rt.new_bool(true))
				},
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(rt.new_bool(true))
				},
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'zipmoney' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Zip Co - Buy Now, Pay Later'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Give your customers the power to pay later, interest free and watch your sales grow.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val:
				(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/zipco.png' },
			rt.ArrayItem{
				key: 'image_72x72'
				val:
					(rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/payment_methods/72x72/zipco.png'
			},
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'zipmoney-payments-woocommerce' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: false },
			rt.ArrayItem{ key: 'category_other', val: rt.new_array() },
			rt.ArrayItem{ key: 'category_additional', val: rt.new_array() },
		]) },
	])
	mut var_base_location := rt.call_function('wc_get_base_location', []rt.PhpVal{})
	mut var_country := var_base_location.array_get(rt.new_string('country'))
	mut iter_1 := var_payment_gateways.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_payment_gateway := item_1.val
		mut var_index := item_1.key
		var_payment_gateways.array_get_mut(var_index).array_set('recommendation_priority', Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_recommendation_priority(var_payment_gateway.array_get(rt.new_string('id')),
			var_country.clone()))
	}
	return var_payment_gateways.clone()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'US' },
		rt.ArrayItem{ key: none, val: 'PR' }, rt.ArrayItem{ key: none, val: 'AU' },
		rt.ArrayItem{ key: none, val: 'CA' }, rt.ArrayItem{ key: none, val: 'CY' },
		rt.ArrayItem{ key: none, val: 'DE' }, rt.ArrayItem{ key: none, val: 'DK' },
		rt.ArrayItem{ key: none, val: 'EE' }, rt.ArrayItem{ key: none, val: 'ES' },
		rt.ArrayItem{ key: none, val: 'FI' }, rt.ArrayItem{ key: none, val: 'FR' },
		rt.ArrayItem{ key: none, val: 'GB' }, rt.ArrayItem{ key: none, val: 'GR' },
		rt.ArrayItem{ key: none, val: 'IE' }, rt.ArrayItem{ key: none, val: 'IT' },
		rt.ArrayItem{ key: none, val: 'LU' }, rt.ArrayItem{ key: none, val: 'LT' },
		rt.ArrayItem{ key: none, val: 'LV' }, rt.ArrayItem{ key: none, val: 'NO' },
		rt.ArrayItem{ key: none, val: 'NZ' }, rt.ArrayItem{ key: none, val: 'MT' },
		rt.ArrayItem{ key: none, val: 'AT' }, rt.ArrayItem{ key: none, val: 'BE' },
		rt.ArrayItem{ key: none, val: 'NL' }, rt.ArrayItem{ key: none, val: 'PL' },
		rt.ArrayItem{ key: none, val: 'PT' }, rt.ArrayItem{ key: none, val: 'CH' },
		rt.ArrayItem{ key: none, val: 'HK' }, rt.ArrayItem{ key: none, val: 'SI' },
		rt.ArrayItem{ key: none, val: 'SK' }, rt.ArrayItem{ key: none, val: 'SG' },
		rt.ArrayItem{ key: none, val: 'BG' }, rt.ArrayItem{ key: none, val: 'CZ' },
		rt.ArrayItem{ key: none, val: 'HR' }, rt.ArrayItem{ key: none, val: 'HU' },
		rt.ArrayItem{ key: none, val: 'RO' }, rt.ArrayItem{ key: none, val: 'SE' },
		rt.ArrayItem{ key: none, val: 'JP' }, rt.ArrayItem{ key: none, val: 'AE' }])
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(var_countries rt.PhpVal) rt.PhpVal {
	mut var_rules := rt.new_array()
	mut iter_2 := var_countries.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_country := item_2.val
		var_rules.array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'base_location_country' },
			rt.ArrayItem{ key: 'value', val: var_country },
			rt.ArrayItem{ key: 'operation', val: '=' },
		])))
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'or' },
		rt.ArrayItem{ key: 'operands', val: var_rules },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_selling_venues(var_selling_venues rt.PhpVal) rt.PhpVal {
	mut var_rules := rt.new_array()
	mut iter_3 := var_selling_venues.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_venue := item_3.val
		var_rules.array_push(rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'option' },
			rt.ArrayItem{ key: 'transformers', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'use', val: 'dot_notation' },
					rt.ArrayItem{ key: 'arguments', val: rt.array_to_object(rt.create_array([
						rt.ArrayItem{ key: 'path', val: 'selling_venues' },
					])) },
				])) },
			]) },
			rt.ArrayItem{ key: 'option_name', val: 'woocommerce_onboarding_profile' },
			rt.ArrayItem{ key: 'operation', val: '=' },
			rt.ArrayItem{ key: 'value', val: var_venue },
			rt.ArrayItem{ key: 'default', val: rt.new_array() },
		])))
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'or' },
		rt.ArrayItem{ key: 'operands', val: var_rules },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_selling_offline() rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'option' },
		rt.ArrayItem{ key: 'transformers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'use', val: 'dot_notation' },
				rt.ArrayItem{ key: 'arguments', val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'path', val: 'selling_online_answer' },
				])) },
			])) },
		]) },
		rt.ArrayItem{ key: 'option_name', val: 'woocommerce_onboarding_profile' },
		rt.ArrayItem{ key: 'operation', val: 'in' },
		rt.ArrayItem{ key: 'value', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'no_im_selling_offline' },
			rt.ArrayItem{ key: none, val: 'im_selling_both_online_and_offline' },
		]) },
		rt.ArrayItem{ key: 'default', val: '' },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(var_should_have rt.PhpVal) rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'option' },
		rt.ArrayItem{ key: 'transformers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'use', val: 'dot_notation' },
				rt.ArrayItem{ key: 'arguments', val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'path', val: 'industry' },
				])) },
			])) },
			rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'use', val: 'array_column' },
				rt.ArrayItem{ key: 'arguments', val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'key', val: 'slug' },
				])) },
			])) },
		]) },
		rt.ArrayItem{ key: 'option_name', val: 'woocommerce_onboarding_profile' },
		rt.ArrayItem{
			key: 'operation'
			val: if rt.is_true(var_should_have) { 'contains' } else { '!contains' }
		},
		rt.ArrayItem{ key: 'value', val: 'cbd-other-hemp-derived-products' },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(var_should_be rt.PhpVal) rt.PhpVal {
	mut var_active_rule := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'plugins_activated' },
		rt.ArrayItem{ key: 'plugins', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
		]) },
	]))
	if rt.is_true(var_should_be) {
		return mut rt.cast_object_ptr[Class_stdClass](var_active_rule)
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'not' },
		rt.ArrayItem{ key: 'operand', val: rt.create_array([
			rt.ArrayItem{ key: none, val: var_active_rule },
		]) },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(var_should_be rt.PhpVal) rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'option' },
		rt.ArrayItem{ key: 'transformers', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'use', val: 'dot_notation' },
				rt.ArrayItem{ key: 'arguments', val: rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'path', val: 'data' },
				])) },
			])) },
			rt.ArrayItem{ key: none, val: rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'use', val: 'array_keys' },
			])) },
		]) },
		rt.ArrayItem{ key: 'option_name', val: 'wcpay_account_data' },
		rt.ArrayItem{
			key: 'operation'
			val: if rt.is_true(var_should_be) { 'contains' } else { '!contains' }
		},
		rt.ArrayItem{ key: 'value', val: 'account_id' },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_recommendation_priority(var_gateway_id rt.PhpVal, var_country_code rt.PhpVal) i64 {
	mut var_recommendation_priority_map := rt.create_array([
		rt.ArrayItem{ key: 'US', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
			rt.ArrayItem{ key: none, val: 'affirm' },
			rt.ArrayItem{ key: none, val: 'afterpay' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'CA', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'affirm' },
			rt.ArrayItem{ key: none, val: 'afterpay' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'AT', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'BE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'BG', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'HR', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'CH', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'CY', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'CZ', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'DK', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'EE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
		]) },
		rt.ArrayItem{ key: 'ES', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'FI', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'kco' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'FR', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'DE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'GB', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'GR', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
		]) },
		rt.ArrayItem{ key: 'HU', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'IE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'IT', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'LV', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'LT', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'LU', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'MT', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'NL', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'NO', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'kco' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'PL', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'mollie_wc_gateway_banktransfer' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'PT', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'RO', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'SK', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'SL', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'SE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'kco' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'MX', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'BR', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'AR', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'BO', val: rt.new_array() },
		rt.ArrayItem{ key: 'CL', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'CO', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'EC', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'FK', val: rt.new_array() },
		rt.ArrayItem{ key: 'GF', val: rt.new_array() },
		rt.ArrayItem{ key: 'GY', val: rt.new_array() },
		rt.ArrayItem{ key: 'PY', val: rt.new_array() },
		rt.ArrayItem{ key: 'PE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'SR', val: rt.new_array() },
		rt.ArrayItem{ key: 'UY', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woo-mercado-pago-custom' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'VE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'AU', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'afterpay' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'NZ', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'klarna_payments' },
		]) },
		rt.ArrayItem{ key: 'HK', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'payoneer-checkout' },
		]) },
		rt.ArrayItem{ key: 'JP', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'square_credit_card' },
			rt.ArrayItem{ key: none, val: 'amazon_payments_advanced' },
		]) },
		rt.ArrayItem{ key: 'SG', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'CN', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'airwallex_main' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
			rt.ArrayItem{ key: none, val: 'payoneer-checkout' },
		]) },
		rt.ArrayItem{ key: 'FJ', val: rt.new_array() },
		rt.ArrayItem{ key: 'GU', val: rt.new_array() },
		rt.ArrayItem{ key: 'ID', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'IN', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'stripe' },
			rt.ArrayItem{ key: none, val: 'razorpay' },
			rt.ArrayItem{ key: none, val: 'payubiz' },
			rt.ArrayItem{ key: none, val: 'ppcp-gateway' },
		]) },
		rt.ArrayItem{ key: 'ZA', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'payfast' },
			rt.ArrayItem{ key: none, val: 'paystack' },
		]) },
		rt.ArrayItem{ key: 'NG', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'paystack' },
		]) },
		rt.ArrayItem{ key: 'GH', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'paystack' },
		]) },
		rt.ArrayItem{ key: 'AE', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:with-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments:without-in-person-payments' },
			rt.ArrayItem{ key: none, val: 'woocommerce_payments' },
		]) },
	])
	if !(var_recommendation_priority_map.array_isset(var_country_code)) {
		return (Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_default_recommendation_priority(var_gateway_id.clone())).to_i64()
	}
	mut var_index := rt.call_function('array_search', [var_gateway_id.clone(),
		var_recommendation_priority_map.array_get(var_country_code),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_index)) {
		return var_recommendation_priority_map.array_get(var_country_code).array_count()
	}
	return var_index.to_i64()
}

fn Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_default_recommendation_priority(var_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways', 'recommendation_priority').array_isset(var_id.clone())))))) {
		return rt.new_null()
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways',
		'recommendation_priority').array_get(var_id)
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_all()
		}
		'get_wcpay_countries' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_wcpay_countries()
		}
		'get_rules_for_countries' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_countries(dispatch_arg_0)
		}
		'get_rules_for_selling_venues' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_selling_venues(dispatch_arg_0)
		}
		'get_rules_selling_offline' {
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_selling_offline()
		}
		'get_rules_for_cbd' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_cbd(dispatch_arg_0)
		}
		'get_rules_for_wcpay_activated' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_activated(dispatch_arg_0)
		}
		'get_rules_for_wcpay_connected' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_rules_for_wcpay_connected(dispatch_arg_0)
		}
		'get_recommendation_priority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_int(Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_recommendation_priority(dispatch_arg_0,
				dispatch_arg_1))
		}
		'get_default_recommendation_priority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways.get_default_recommendation_priority(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
