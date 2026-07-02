import rt

struct Class_WC_Payment_Gateway_CC {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Payment_Gateway_CC) payment_fields() {
	if rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()))
		&& rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{})) {
		this.tokenization_script()
		this.saved_payment_methods()
		this.form()
		this.save_payment_method_checkbox()
	} else {
		this.form()
	}
}

fn (mut this Class_WC_Payment_Gateway_CC) field_name(var_name rt.PhpVal) string {
	return if rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization())) {
		''
	} else {
		' name="' +
			(rt.call_function('esc_attr', [rt.new_string((rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')).str() +
			'-' + var_name.str())])).str() + '" '
	}
}

fn (mut this Class_WC_Payment_Gateway_CC) form() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-credit-card-form')])
	mut var_fields := rt.new_array()
	mut var_cvc_field := rt.new_string('<p class="form-row form-row-last">\n\t\t\t<label for="' +
		(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
		'-card-cvc">' +
		(rt.call_function('esc_html__', [rt.new_string('Card code'), rt.new_string('woocommerce')])).str() +
		'&nbsp;<span class="required">*</span></label>\n\t\t\t<input id="' +
		(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
		'-card-cvc" class="input-text wc-credit-card-form-card-cvc" inputmode="numeric" autocomplete="off" autocorrect="no" autocapitalize="no" spellcheck="no" type="tel" maxlength="4" placeholder="' +
		(rt.call_function('esc_attr__', [rt.new_string('CVC'), rt.new_string('woocommerce')])).str() +
		'" ' + this.field_name(rt.new_string('card-cvc')) + ' style="width:100px" />\n\t\t</p>')
	mut var_default_fields := {
		'card-number-field': '<p class="form-row form-row-wide">\n\t\t\t\t<label for="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-card-number">' +
			(rt.call_function('esc_html__', [rt.new_string('Card number'), rt.new_string('woocommerce')])).str() +
			'&nbsp;<span class="required">*</span></label>\n\t\t\t\t<input id="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-card-number" class="input-text wc-credit-card-form-card-number" inputmode="numeric" autocomplete="cc-number" autocorrect="no" autocapitalize="no" spellcheck="no" type="tel" placeholder="&bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull;" ' +
			this.field_name(rt.new_string('card-number')) + ' />\n\t\t\t</p>'
		'card-expiry-field': '<p class="form-row form-row-first">\n\t\t\t\t<label for="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-card-expiry">' +
			(rt.call_function('esc_html__', [rt.new_string('Expiry (MM/YY)'), rt.new_string('woocommerce')])).str() +
			'&nbsp;<span class="required">*</span></label>\n\t\t\t\t<input id="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-card-expiry" class="input-text wc-credit-card-form-card-expiry" inputmode="numeric" autocomplete="cc-exp" autocorrect="no" autocapitalize="no" spellcheck="no" type="tel" placeholder="' +
			(rt.call_function('esc_attr__', [rt.new_string('MM / YY'), rt.new_string('woocommerce')])).str() +
			'" ' + this.field_name(rt.new_string('card-expiry')) + ' />\n\t\t\t</p>'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.credit_card_form_cvc_on_saved_method()))))) {
		var_default_fields['card-cvc-field'] = var_cvc_field.clone()
	}
	var_fields = rt.call_function('wp_parse_args', [var_fields.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_credit_card_form_fields'),
			rt.create_array_from_native_map(var_default_fields),
			rt.get_property(rt.new_object('WC_Payment_Gateway_CC', [
				'WC_Payment_Gateway',
			], &this), 'id'),
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_credit_card_form_start'),
		rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_1 := var_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		rt.echo_val(var_field)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_credit_card_form_end'),
		rt.get_property(rt.new_object('WC_Payment_Gateway_CC', ['WC_Payment_Gateway'], &this), 'id')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.credit_card_form_cvc_on_saved_method())) {
		print('<fieldset>' + var_cvc_field.str() + '</fieldset>')
	}
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

fn create_wc_payment_gateway_cc(_args ...rt.PhpVal) &Class_WC_Payment_Gateway_CC {
	mut obj := &Class_WC_Payment_Gateway_CC{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateway(_args ...rt.PhpVal) &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Gateway_CC) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'payment_fields' {
			this.payment_fields()
			return rt.new_null()
		}
		'field_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.field_name(dispatch_arg_0))
		}
		'form' {
			this.form()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Gateway_CC) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway_CC) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Gateway) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateway) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
