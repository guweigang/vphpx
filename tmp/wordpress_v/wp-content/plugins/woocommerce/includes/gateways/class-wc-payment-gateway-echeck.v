import rt

struct Class_WC_Payment_Gateway_ECheck {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Payment_Gateway_ECheck) payment_fields() {
	if rt.is_true(rt.new_bool(
		rt.is_true(this.supports(Class_Automattic_WooCommerce_Enums_PaymentGatewayFeature.tokenization()))
		&& rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))
	{
		this.tokenization_script()
		this.saved_payment_methods()
		this.form()
		this.save_payment_method_checkbox()
	} else {
		this.form()
	}
}

fn (mut this Class_WC_Payment_Gateway_ECheck) form() {
	mut var_fields := rt.new_array()
	mut var_default_fields := {
		'routing-number': '<p class="form-row form-row-first">\n\t\t\t\t<label for="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-routing-number">' +
			(rt.call_function('esc_html__', [rt.new_string('Routing number'), rt.new_string('woocommerce')])).str() +
			'&nbsp;<span class="required">*</span></label>\n\t\t\t\t<input id="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-routing-number" class="input-text wc-echeck-form-routing-number" type="text" maxlength="9" autocomplete="off" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" name="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-routing-number" />\n\t\t\t</p>'
		'account-number': '<p class="form-row form-row-wide">\n\t\t\t\t<label for="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-account-number">' +
			(rt.call_function('esc_html__', [rt.new_string('Account number'), rt.new_string('woocommerce')])).str() +
			'&nbsp;<span class="required">*</span></label>\n\t\t\t\t<input id="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-account-number" class="input-text wc-echeck-form-account-number" type="text" autocomplete="off" name="' +
			(rt.call_function('esc_attr', [rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', ['WC_Payment_Gateway'], &this), 'id')])).str() +
			'-account-number" maxlength="17" />\n\t\t\t</p>'
	}
	var_fields = rt.call_function('wp_parse_args', [var_fields.dup(),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_echeck_form_fields'),
			var_default_fields.dup(),
			rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', [
				'WC_Payment_Gateway',
			], &this), 'id'),
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', [
			'WC_Payment_Gateway',
		], &this), 'id'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_echeck_form_start'),
		rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', [
			'WC_Payment_Gateway',
		], &this), 'id')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			rt.echo_val(var_field)
			// unsupported statement: Stmt_Nop
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_echeck_form_end'),
		rt.get_property(rt.new_object('WC_Payment_Gateway_ECheck', [
			'WC_Payment_Gateway',
		], &this), 'id')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

fn create_wc_payment_gateway_echeck() &Class_WC_Payment_Gateway_ECheck {
	mut obj := &Class_WC_Payment_Gateway_ECheck{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateway() &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Gateway_ECheck) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'payment_fields' {
			this.payment_fields()
			return rt.new_null()
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

fn (this &Class_WC_Payment_Gateway_ECheck) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateway_ECheck) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_includes_gateways_class_wc_payment_gateway_echeck_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
