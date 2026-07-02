import rt

struct Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_all() rt.PhpVal {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_0 := iife_temp_0.get_rules_for_cbd(rt.new_bool(false))
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_1 :=
		iife_temp_1.get_rules_for_countries(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_woopay_available_countries())
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_2 := iife_temp_2.get_rules_for_cbd(rt.new_bool(false))
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_3 := iife_temp_3.get_wcpay_countries()
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{}
	mut iife_result_4 := iife_temp_4.get_rules_for_countries(iife_result_3)
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments:woopay' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Payments made simple — including WooPay, a new express checkout feature.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: rt.call_function('plugins_url', [
				rt.new_string('assets/images/onboarding/wcpay.svg'),
				rt.get_constant('WC_PLUGIN_FILE'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: iife_result_0 },
				rt.ArrayItem{ key: none, val: iife_result_1 },
			]) },
			rt.ArrayItem{
				key: 'sub_title'
				val: Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_wcpay_payment_icons()
			},
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'woocommerce_payments' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('WooPayments'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
				rt.new_string('Payments made simple, with no monthly fees – designed exclusively for WooCommerce stores. Accept credit cards, debit cards, and other popular payment methods.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'image', val: rt.call_function('plugins_url', [
				rt.new_string('assets/images/onboarding/wcpay.svg'),
				rt.get_constant('WC_PLUGIN_FILE'),
			]) },
			rt.ArrayItem{ key: 'plugins', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce-payments' },
			]) },
			rt.ArrayItem{ key: 'is_visible', val: rt.create_array([
				rt.ArrayItem{ key: none, val: iife_result_2 },
				rt.ArrayItem{ key: none, val: iife_result_4 },
			]) },
			rt.ArrayItem{
				key: 'sub_title'
				val: Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_wcpay_payment_icons()
			},
		]) },
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_woopay_available_countries() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'US' }])
}

fn Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_wcpay_payment_icons() string {
	mut var_icons := rt.create_array([rt.ArrayItem{ key: none, val: 'visa' },
		rt.ArrayItem{ key: none, val: 'mastercard' }, rt.ArrayItem{ key: none, val: 'amex' },
		rt.ArrayItem{ key: none, val: 'googlepay' }, rt.ArrayItem{ key: none, val: 'applepay' }])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_icon := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return (rt.call_function('sprintf', [
			rt.new_string('<img class="wcpay-%s-icon wcpay-icon" src="%s" alt="%s">'),
			var_icon.clone(),
			rt.call_function('plugins_url', [
				rt.new_string('assets/images/payment-methods/${var_icon.to_string()}.svg'),
				rt.get_constant('WC_PLUGIN_FILE'),
			]),
			rt.call_function('ucfirst', [
				var_icon.clone(),
			]),
		])).str()
	}
	mut var_convert_to_img_tag := rt.new_closure(closure_6_fn)
	return (rt.call_function('implode', [rt.new_string(''),
		rt.call_function('array_map', [var_convert_to_img_tag.clone(),
			var_icons.clone()])])).str()
}

struct Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_wcpaypromotion_defaultpromotions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_paymentgatewaysuggestions_defaultpaymentgateways(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_all()
		}
		'get_woopay_available_countries' {
			return Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_woopay_available_countries()
		}
		'get_wcpay_payment_icons' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions.get_wcpay_payment_icons())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_WCPayPromotion_DefaultPromotions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_PaymentGatewaySuggestions_DefaultPaymentGateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
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
