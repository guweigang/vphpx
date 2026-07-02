import rt

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
pub mut:
	order_button_text             rt.PhpVal = rt.new_null()
	has_custom_place_order_button rt.PhpVal = rt.new_bool(false)
	enabled                       string
	title                         rt.PhpVal = rt.new_null()
	description                   rt.PhpVal = rt.new_null()
	chosen                        bool
	method_title                  rt.PhpVal = rt.new_string('')
	method_description            rt.PhpVal = rt.new_string('')
	has_fields                    rt.PhpVal = rt.new_null()
	countries                     rt.PhpVal = rt.new_null()
	availability                  rt.PhpVal = rt.new_null()
	icon                          rt.PhpVal = rt.new_null()
	supports                      rt.PhpVal = rt.new_array()
	max_amount                    rt.PhpVal = rt.new_int(0)
	view_transaction_url          rt.PhpVal = rt.new_string('')
	new_method_label              rt.PhpVal = rt.new_string('')
	pay_button_id                 rt.PhpVal = rt.new_string('')
	tokens                        rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Payment_Gateway) get_tokens() rt.PhpVal {
	if this.tokens.array_count() > 0 {
		return this.tokens
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization())) {
		mut iife_temp_0 := Class_WC_Payment_Tokens{}
		mut iife_result_0 := iife_temp_0.get_customer_tokens(rt.call_function('get_current_user_id',
			[]rt.PhpVal{}), rt.get_property(rt.new_object('WC_Payment_Gateway', [
			'WC_Settings_API',
		], &this), 'id'))
		this.tokens = iife_result_0
	}
	return this.tokens
}

fn (mut this Class_WC_Payment_Gateway) get_method_title() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_gateway_method_title'),
		this.method_title,
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) get_method_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_gateway_method_description'),
		this.method_description,
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) admin_options() {
	mut var_offline_payment_gateways := [Class_WC_Gateway_BACS.id(),
		Class_WC_Gateway_Cheque.id(), Class_WC_Gateway_COD.id()]
	mut var_is_offline_gateway := rt.call_function('in_array', [
		rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'id'),
		rt.create_array_from_list(var_offline_payment_gateways),
		rt.new_bool(true),
	])
	mut var_return_path := rt.new_null()
	if rt.is_true(var_is_offline_gateway) {
		mut var_offline_section := if rt.is_true(rt.call_function('class_exists', [
			rt.new_string('WC_Settings_Payment_Gateways'),
		]))
		{
			Class_WC_Settings_Payment_Gateways.offline_section_name()
		} else {
			rt.new_string('offline')
		}
		var_return_path = rt.new_string('/' + var_offline_section.str())
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}
	mut iife_result_1 := iife_temp_1.wc_payments_settings_url(var_return_path.clone())
	rt.call_function('wc_back_header', [this.get_method_title(),
		rt.call_function('esc_html__', [rt.new_string('Return to payments'),
			rt.new_string('woocommerce')]),
		iife_result_1])
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [this.get_method_description()]),
	]))
	this.Class_WC_Settings_API.admin_options()
}

fn (mut this Class_WC_Payment_Gateway) init_settings() {
	this.Class_WC_Settings_API.init_settings()
	this.enabled = if
		!(!rt.is_true(rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'settings').array_get(rt.new_string('enabled'))))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'settings').array_get(rt.new_string('enabled')))) {
		'yes'
	} else {
		'no'
	}
}

fn (mut this Class_WC_Payment_Gateway) needs_setup() bool {
	return false
}

fn (mut this Class_WC_Payment_Gateway) get_return_url(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	if rt.is_true(var_order_mutated) {
		mut var_return_url := rt.call_method(var_order_mutated, 'get_checkout_order_received_url',
			[]rt.PhpVal{})
	} else {
		var_return_url = rt.call_function('wc_get_endpoint_url', [
			rt.new_string('order-received'),
			rt.new_string(''),
			rt.call_function('wc_get_checkout_url', []rt.PhpVal{}),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_return_url'),
		var_return_url.clone(),
		var_order_mutated.clone(),
	])
}

fn (mut this Class_WC_Payment_Gateway) get_transaction_url(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_return_url := rt.new_string('')
	mut var_transaction_id := rt.call_method(var_order_mutated, 'get_transaction_id', []rt.PhpVal{})
	if !(!rt.is_true(this.view_transaction_url)) && !(!rt.is_true(var_transaction_id)) {
		var_return_url = rt.call_function('sprintf',
			[this.view_transaction_url, var_transaction_id.clone()])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_transaction_url'),
		var_return_url.clone(),
		var_order_mutated.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) get_order_total() rt.PhpVal {
	mut var_total := rt.new_int(0)
	mut var_order_id := rt.call_function('absint', [
		rt.call_function('get_query_var', [rt.new_string('order-pay')]),
	])
	if rt.is_true(rt.less(rt.new_int(0), var_order_id)) {
		mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
		if rt.is_true(var_order) {
			var_total =
				rt.new_float((rt.call_method(var_order, 'get_total', []rt.PhpVal{})).to_f64())
		}
	} else if rt.is_true(rt.less(rt.new_int(0), rt.get_property(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'cart'), 'total')))
	{
		var_total = rt.new_float((rt.get_property(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'cart'), 'total')).to_f64())
	}
	return var_total.clone()
}

fn (mut this Class_WC_Payment_Gateway) is_available() bool {
	if rt.is_true(rt.new_bool('yes' != this.enabled)) {
		return false
	}
	mut var_is_available := rt.new_bool(true)
	if rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'))
		&& rt.is_true(rt.less(rt.new_int(0), this.get_order_total()))
		&& rt.is_true(rt.less(rt.new_int(0), this.max_amount))
		&& rt.is_true(rt.less(this.max_amount, this.get_order_total())) {
		var_is_available = rt.new_bool(false)
	}
	return var_is_available.to_bool()
}

fn (mut this Class_WC_Payment_Gateway) has_fields() bool {
	return (this.has_fields).to_bool()
}

fn (mut this Class_WC_Payment_Gateway) get_title() rt.PhpVal {
	mut var_title := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.class(),
	]), 'sanitize', [rt.new_string((this.title).str()),
		Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.low_html_balanced_tags_no_links()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_gateway_title'),
		var_title.clone(),
		rt.get_property(rt.new_object('WC_Payment_Gateway', [
			'WC_Settings_API',
		], &this), 'id')])
}

fn (mut this Class_WC_Payment_Gateway) get_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_gateway_description'),
		rt.call_function('wp_kses_post', [this.description]),
		rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'id'),
	])
}

fn (mut this Class_WC_Payment_Gateway) get_icon() rt.PhpVal {
	mut iife_temp_2 := Class_WC_HTTPS{}
	mut iife_result_2 := iife_temp_2.force_https_url(this.icon)
	mut iife_temp_3 := Class_WC_HTTPS{}
	mut iife_result_3 := iife_temp_3.force_https_url(this.icon)
	mut var_icon := rt.new_string((if rt.is_true(this.icon) {
		'<img src="' + (rt.call_function('esc_url', [iife_result_2])).str() + '" alt="' +
			(rt.call_function('esc_attr', [this.get_title()])).str() + '" />'
	} else {
		''
	}).str())
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_gateway_icon'),
		var_icon.clone(),
		rt.get_property(rt.new_object('WC_Payment_Gateway', [
			'WC_Settings_API',
		], &this), 'id')])
}

fn (mut this Class_WC_Payment_Gateway) get_pay_button_id() rt.PhpVal {
	return rt.call_function('sanitize_html_class', [this.pay_button_id])
}

fn (mut this Class_WC_Payment_Gateway) set_current() {
	this.chosen = true
}

fn (mut this Class_WC_Payment_Gateway) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order_id_mutated := var_order_id
	return rt.new_array()
}

fn (mut this Class_WC_Payment_Gateway) process_refund(var_order_id rt.PhpVal, var_amount rt.PhpVal, reason string) bool {
	mut var_order_id_mutated := var_order_id
	return false
}

fn (mut this Class_WC_Payment_Gateway) validate_fields() bool {
	return true
}

fn (mut this Class_WC_Payment_Gateway) payment_fields() {
	mut var_description := this.get_description()
	if rt.is_true(var_description) {
		rt.echo_val(rt.call_function('wpautop', [
			rt.call_function('wptexturize', [var_description.clone()]),
		]))
	}
	if rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.default_credit_card_form())) {
		this.credit_card_form(rt.new_null(), rt.new_null())
	}
}

fn (mut this Class_WC_Payment_Gateway) supports(var_feature rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateway_supports'),
		rt.call_function('in_array', [var_feature.clone(), this.supports, rt.new_bool(true)]),
		var_feature.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) can_refund_order(var_order rt.PhpVal) bool {
	mut var_order_mutated := var_order
	return rt.is_true(var_order_mutated)
		&& rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.refunds()))
}

fn (mut this Class_WC_Payment_Gateway) credit_card_form(var_args rt.PhpVal, var_fields rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [rt.new_string('credit_card_form'),
		rt.new_string('2.6'), rt.new_string('WC_Payment_Gateway_CC->form')])
	mut var_cc_form := create_wc_payment_gateway_cc()
	rt.set_property(var_cc_form, 'id', rt.get_property(rt.new_object('WC_Payment_Gateway', [
		'WC_Settings_API',
	], &this), 'id'))
	rt.set_property(var_cc_form, 'supports', this.supports)
	var_cc_form.form()
}

fn (mut this Class_WC_Payment_Gateway) tokenization_script() {
	mut iife_temp_4 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_4 := iife_temp_4.is_true(rt.new_string('SCRIPT_DEBUG'))
	mut iife_temp_5 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_5 := iife_temp_5.is_true(rt.new_string('SCRIPT_DEBUG'))
	rt.call_function('wp_enqueue_script', [
		rt.new_string('woocommerce-tokenization-form'),
		rt.call_function('plugins_url', [
			rt.new_string('/assets/js/frontend/tokenization-form' +
				if rt.is_true(iife_result_4) { '' } else { '.min' } + '.js'),
			rt.get_constant('WC_PLUGIN_FILE'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'jquery' },
		]),
		rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'),
		rt.new_bool(false),
	])
	rt.call_function('wp_localize_script', [
		rt.new_string('woocommerce-tokenization-form'),
		rt.new_string('wc_tokenization_form_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'is_registration_required', val: rt.call_method(rt.call_method(rt.call_function('WC',
				[]rt.PhpVal{}), 'checkout', []rt.PhpVal{}), 'is_registration_required',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'is_logged_in', val: rt.call_function('is_user_logged_in',
				[]rt.PhpVal{}) },
		]),
	])
}

fn (mut this Class_WC_Payment_Gateway) saved_payment_methods() {
	mut var_html := rt.new_string(
		'<ul class="woocommerce-SavedPaymentMethods wc-saved-payment-methods" data-count="' +
		(rt.call_function('esc_attr', [rt.new_int(this.get_tokens().array_count())])).str() + '">')
	mut iter_1 := this.get_tokens().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_token := item_1.val
		var_html = rt.concat(var_html, this.get_saved_payment_method_option_html(var_token.clone()))
	}
	var_html = rt.concat(var_html, this.get_new_payment_method_option_html())
	var_html = rt.concat(var_html, rt.new_string('</ul>'))
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('wc_payment_gateway_form_saved_payment_methods_html'),
		var_html.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	]))
}

fn (mut this Class_WC_Payment_Gateway) get_saved_payment_method_option_html(var_token rt.PhpVal) rt.PhpVal {
	mut var_html := rt.call_function('sprintf', [
		rt.new_string('<li class="woocommerce-SavedPaymentMethods-token">\n\t\t\t\t<input id="wc-%1$s-payment-token-%2$s" type="radio" name="wc-%1$s-payment-token" value="%2$s" style="width:auto;" class="woocommerce-SavedPaymentMethods-tokenInput" %4$s />\n\t\t\t\t<label for="wc-%1$s-payment-token-%2$s">%3$s</label>\n\t\t\t</li>'),
		rt.call_function('esc_attr', [
			rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'id'),
		]),
		rt.call_function('esc_attr', [
			rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
		]),
		rt.call_function('esc_html', [
			rt.call_method(var_token, 'get_display_name', []rt.PhpVal{}),
		]),
		rt.call_function('checked', [
			rt.call_method(var_token, 'is_default', []rt.PhpVal{}),
			rt.new_bool(true),
			rt.new_bool(false),
		]),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateway_get_saved_payment_method_option_html'),
		var_html.clone(),
		var_token.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) get_new_payment_method_option_html() rt.PhpVal {
	mut var_label := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateway_get_new_payment_method_option_html_label'),
		if rt.is_true(this.new_method_label) { this.new_method_label } else { rt.call_function('__', [
				rt.new_string('Use a new payment method'),
				rt.new_string('woocommerce'),
			]) },
		rt.new_object('WC_Payment_Gateway', [
			'WC_Settings_API',
		], &this),
	])
	mut var_html := rt.call_function('sprintf', [
		rt.new_string('<li class="woocommerce-SavedPaymentMethods-new">\n\t\t\t\t<input id="wc-%1$s-payment-token-new" type="radio" name="wc-%1$s-payment-token" value="new" style="width:auto;" class="woocommerce-SavedPaymentMethods-tokenInput" />\n\t\t\t\t<label for="wc-%1$s-payment-token-new">%2$s</label>\n\t\t\t</li>'),
		rt.call_function('esc_attr', [
			rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'id'),
		]),
		rt.call_function('esc_html', [
			var_label.clone(),
		]),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateway_get_new_payment_method_option_html'),
		var_html.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Payment_Gateway) save_payment_method_checkbox() {
	mut var_html := rt.call_function('sprintf', [
		rt.new_string('<p class="form-row woocommerce-SavedPaymentMethods-saveNew">\n\t\t\t\t<input id="wc-%1$s-new-payment-method" name="wc-%1$s-new-payment-method" type="checkbox" value="true" style="width:auto;" />\n\t\t\t\t<label for="wc-%1$s-new-payment-method" style="display:inline;">%2$s</label>\n\t\t\t</p>'),
		rt.call_function('esc_attr', [
			rt.get_property(rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this), 'id'),
		]),
		rt.call_function('esc_html__', [
			rt.new_string('Save to account'),
			rt.new_string('woocommerce'),
		]),
	])
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_gateway_save_new_payment_method_option_html'),
		var_html.clone(),
		rt.new_object('WC_Payment_Gateway', ['WC_Settings_API'], &this),
	]))
}

fn (mut this Class_WC_Payment_Gateway) add_payment_method() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'result', val: 'failure' },
		rt.ArrayItem{ key: 'redirect', val: rt.call_function('wc_get_endpoint_url', [
			rt.new_string('payment-methods'),
		]) }])
}

struct Class_WC_Settings_API {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_WC_HTTPS {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Gateway_CC {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_payment_gateway(_args ...rt.PhpVal) &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase:                 rt.PhpObjectBase{}
		order_button_text:             rt.new_null()
		has_custom_place_order_button: rt.new_bool(false)
		enabled:                       ''
		title:                         rt.new_null()
		description:                   rt.new_null()
		chosen:                        false
		method_title:                  rt.new_string('')
		method_description:            rt.new_string('')
		has_fields:                    rt.new_null()
		countries:                     rt.new_null()
		availability:                  rt.new_null()
		icon:                          rt.new_null()
		supports:                      rt.new_array()
		max_amount:                    rt.new_int(0)
		view_transaction_url:          rt.new_string('')
		new_method_label:              rt.new_string('')
		pay_button_id:                 rt.new_string('')
		tokens:                        rt.new_array()
	}
	return obj
}

fn create_wc_settings_api(_args ...rt.PhpVal) &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_tokens(_args ...rt.PhpVal) &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_https(_args ...rt.PhpVal) &Class_WC_HTTPS {
	mut obj := &Class_WC_HTTPS{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateway_cc(_args ...rt.PhpVal) &Class_WC_Payment_Gateway_CC {
	mut obj := &Class_WC_Payment_Gateway_CC{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_tokens' {
			return this.get_tokens()
		}
		'get_method_title' {
			return this.get_method_title()
		}
		'get_method_description' {
			return this.get_method_description()
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'init_settings' {
			this.init_settings()
			return rt.new_null()
		}
		'needs_setup' {
			return rt.new_bool(this.needs_setup())
		}
		'get_return_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_return_url(dispatch_arg_0)
		}
		'get_transaction_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_transaction_url(dispatch_arg_0)
		}
		'get_order_total' {
			return this.get_order_total()
		}
		'is_available' {
			return rt.new_bool(this.is_available())
		}
		'has_fields' {
			return rt.new_bool(this.has_fields())
		}
		'get_title' {
			return this.get_title()
		}
		'get_description' {
			return this.get_description()
		}
		'get_icon' {
			return this.get_icon()
		}
		'get_pay_button_id' {
			return this.get_pay_button_id()
		}
		'set_current' {
			this.set_current()
			return rt.new_null()
		}
		'process_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_payment(dispatch_arg_0)
		}
		'process_refund' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.process_refund(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'validate_fields' {
			return rt.new_bool(this.validate_fields())
		}
		'payment_fields' {
			this.payment_fields()
			return rt.new_null()
		}
		'supports' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.supports(dispatch_arg_0)
		}
		'can_refund_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.can_refund_order(dispatch_arg_0))
		}
		'credit_card_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.credit_card_form(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'tokenization_script' {
			this.tokenization_script()
			return rt.new_null()
		}
		'saved_payment_methods' {
			this.saved_payment_methods()
			return rt.new_null()
		}
		'get_saved_payment_method_option_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_saved_payment_method_option_html(dispatch_arg_0)
		}
		'get_new_payment_method_option_html' {
			return this.get_new_payment_method_option_html()
		}
		'save_payment_method_checkbox' {
			this.save_payment_method_checkbox()
			return rt.new_null()
		}
		'add_payment_method' {
			return this.add_payment_method()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'order_button_text' { return this.order_button_text }
		'has_custom_place_order_button' { return this.has_custom_place_order_button }
		'enabled' { return rt.new_string(this.enabled) }
		'title' { return this.title }
		'description' { return this.description }
		'chosen' { return rt.new_bool(this.chosen) }
		'method_title' { return this.method_title }
		'method_description' { return this.method_description }
		'has_fields' { return this.has_fields }
		'countries' { return this.countries }
		'availability' { return this.availability }
		'icon' { return this.icon }
		'supports' { return this.supports }
		'max_amount' { return this.max_amount }
		'view_transaction_url' { return this.view_transaction_url }
		'new_method_label' { return this.new_method_label }
		'pay_button_id' { return this.pay_button_id }
		'tokens' { return this.tokens }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'order_button_text' {
			this.order_button_text = val
			return true
		}
		'has_custom_place_order_button' {
			this.has_custom_place_order_button = val
			return true
		}
		'enabled' {
			this.enabled = val.str()
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'chosen' {
			this.chosen = val.to_bool()
			return true
		}
		'method_title' {
			this.method_title = val
			return true
		}
		'method_description' {
			this.method_description = val
			return true
		}
		'has_fields' {
			this.has_fields = val
			return true
		}
		'countries' {
			this.countries = val
			return true
		}
		'availability' {
			this.availability = val
			return true
		}
		'icon' {
			this.icon = val
			return true
		}
		'supports' {
			this.supports = val
			return true
		}
		'max_amount' {
			this.max_amount = val
			return true
		}
		'view_transaction_url' {
			this.view_transaction_url = val
			return true
		}
		'new_method_label' {
			this.new_method_label = val
			return true
		}
		'pay_button_id' {
			this.pay_button_id = val
			return true
		}
		'tokens' {
			this.tokens = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_HTTPS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_HTTPS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_HTTPS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Gateway_CC) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateway_CC) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway_CC) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
}
