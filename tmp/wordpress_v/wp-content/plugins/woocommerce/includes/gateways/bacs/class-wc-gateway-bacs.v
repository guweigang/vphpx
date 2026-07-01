import rt

pub fn Class_WC_Gateway_BACS.id() string {
	return 'bacs'
}
struct Class_WC_Gateway_BACS {
	rt.PhpObjectBase
pub mut:
		locale rt.PhpVal = rt.new_null()
		instructions rt.PhpVal = rt.new_null()
		account_details rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_BACS) construct()  {
	this.dispatch_set_prop('id', Class_WC_Gateway_BACS.id())
	this.dispatch_set_prop('icon', rt.call_function('apply_filters', [rt.new_string('woocommerce_bacs_icon'), rt.new_string('')]))
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
	this.dispatch_set_prop('method_title', rt.call_function('__', [rt.new_string('Direct bank transfer'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [rt.new_string('Take payments in person via BACS. More commonly known as direct bank/wire transfer.'), rt.new_string('woocommerce')]))
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('description', this.get_option(rt.new_string('description')))
	this.instructions = this.get_option(rt.new_string('instructions'))
	this.account_details = rt.call_function('get_option', [rt.new_string('woocommerce_bacs_accounts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'account_name', val: this.get_option(rt.new_string('account_name')) }, rt.ArrayItem{ key: 'account_number', val: this.get_option(rt.new_string('account_number')) }, rt.ArrayItem{ key: 'sort_code', val: this.get_option(rt.new_string('sort_code')) }, rt.ArrayItem{ key: 'bank_name', val: this.get_option(rt.new_string('bank_name')) }, rt.ArrayItem{ key: 'iban', val: this.get_option(rt.new_string('iban')) }, rt.ArrayItem{ key: 'bic', val: this.get_option(rt.new_string('bic')) }]) }])])
	rt.call_function('add_action', ['woocommerce_update_options_payment_gateways_' + (rt.get_property(rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this), 'id')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'process_admin_options' }])])
	rt.call_function('add_action', ['woocommerce_update_options_payment_gateways_' + (rt.get_property(rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this), 'id')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'save_account_details' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_thankyou_bacs'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'thankyou_page' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_before_order_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_BACS', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'email_instructions' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_WC_Gateway_BACS) init_form_fields()  {
	this.dispatch_set_prop('form_fields', rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable bank transfer'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: 'no' }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'safe_text' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This controls the title which the user sees during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('__', [rt.new_string('Direct bank transfer'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method description that the customer will see on your checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('__', [rt.new_string('Make your payment directly into our bank account. Please use your Order ID as the payment reference. Your order will not be shipped until the funds have cleared in our account.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'instructions', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Instructions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Instructions that will be added to the thank you page and emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'account_details', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'account_details' }]) }]))
}

fn (mut this Class_WC_Gateway_BACS) generate_account_details_html() rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_country := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'countries'), 'get_base_country', []rt.PhpVal{})
	mut var_locale := this.get_country_locale()
	mut var_sortcode := if var_locale.array_get(var_country).array_get('sortcode').array_isset(rt.new_string('label')) { var_locale.array_get(var_country).array_get('sortcode').array_get('label') } else { rt.call_function('__', [rt.new_string('Sort code'), rt.new_string('woocommerce')]) }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Account details:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('These account details will be displayed within the order thank you page and confirmation email.'), rt.new_string('woocommerce')])])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Account name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Account number'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Bank name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_sortcode.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('IBAN'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('BIC / Swift'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_i := // unsupported expression: Expr_UnaryMinus
	if rt.is_true(this.account_details) {
		{
			mut iter_1 := this.account_details.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_account := item_1.val
				rt.pre_inc(var_i)
				print('<tr class="account">\n\t\t\t\t\t\t\t\t\t\t<td class="sort"></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [rt.call_function('wp_unslash', [var_account.array_get('account_name')])])).str() + '" name="bacs_account_name[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [var_account.array_get('account_number')])).str() + '" name="bacs_account_number[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [rt.call_function('wp_unslash', [var_account.array_get('bank_name')])])).str() + '" name="bacs_bank_name[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [var_account.array_get('sort_code')])).str() + '" name="bacs_sort_code[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [var_account.array_get('iban')])).str() + '" name="bacs_iban[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t\t<td><input type="text" value="' + (rt.call_function('esc_attr', [var_account.array_get('bic')])).str() + '" name="bacs_bic[' + (rt.call_function('esc_attr', [var_i.dup()])).str() + ']" /></td>\n\t\t\t\t\t\t\t\t\t</tr>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('+ Add account'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove selected account(s)'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Gateway_BACS) save_account_details()  {
	mut var_accounts := []rt.PhpVal{}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_account_name')) && rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_account_number')) && rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_bank_name')) && rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_sort_code')) && rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_iban')) && rt.get_superglobal('_POST').array_isset(rt.new_string('bacs_bic')) {
		mut var_account_names := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_account_name')])])
		mut var_account_numbers := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_account_number')])])
		mut var_bank_names := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_bank_name')])])
		mut var_sort_codes := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_sort_code')])])
		mut var_ibans := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_iban')])])
		mut var_bics := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('bacs_bic')])])
		{
			mut iter_1 := var_account_names.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_name := item_1.val
				mut var_i := item_1.key
				if !(var_account_names.array_isset(var_i)) {
					continue
				}
				var_accounts << rt.create_array([rt.ArrayItem{ key: 'account_name', val: var_account_names.array_get(var_i) }, rt.ArrayItem{ key: 'account_number', val: var_account_numbers.array_get(var_i) }, rt.ArrayItem{ key: 'bank_name', val: var_bank_names.array_get(var_i) }, rt.ArrayItem{ key: 'sort_code', val: var_sort_codes.array_get(var_i) }, rt.ArrayItem{ key: 'iban', val: var_ibans.array_get(var_i) }, rt.ArrayItem{ key: 'bic', val: var_bics.array_get(var_i) }])
			}
		}
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_update_option'), rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce_bacs_accounts' }])])
	rt.call_function('update_option', [rt.new_string('woocommerce_bacs_accounts'), var_accounts.dup()])
}

fn (mut this Class_WC_Gateway_BACS) thankyou_page(var_order_id rt.PhpVal)  {
	if rt.is_true(this.instructions) {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [rt.call_function('wp_kses_post', [this.instructions])])])]))
	}
	this.bank_details((var_order_id).str())
}

fn (mut this Class_WC_Gateway_BACS) email_instructions(var_order rt.PhpVal, var_sent_to_admin rt.PhpVal, plain_text bool)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_sent_to_admin)))) && rt.is_true(rt.identical(Class_WC_Gateway_BACS.id(), rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{}))))) {
		mut var_instructions_order_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_bacs_email_instructions_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), var_order_mutated.dup()])
		if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [var_instructions_order_status.dup()])) {
			if rt.is_true(this.instructions) {
				rt.echo_val(rt.call_function('wp_kses_post', [rt.concat(rt.call_function('wpautop', [rt.call_function('wptexturize', [this.instructions])]), rt.get_constant('PHP_EOL'))]))
			}
			this.bank_details((rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str())
		}
	}
}

fn (mut this Class_WC_Gateway_BACS) bank_details(order_id string)  {
	if !rt.is_true(this.account_details) {
		return rt.new_null()
	}
	mut var_order := rt.call_function('wc_get_order', [rt.new_string(order_id)])
	mut var_country := rt.call_method(var_order, 'get_billing_country', []rt.PhpVal{})
	mut var_locale := this.get_country_locale()
	mut var_sortcode := if var_locale.array_get(var_country).array_get('sortcode').array_isset(rt.new_string('label')) { var_locale.array_get(var_country).array_get('sortcode').array_get('label') } else { rt.call_function('__', [rt.new_string('Sort code'), rt.new_string('woocommerce')]) }
	mut var_bacs_accounts := rt.call_function('apply_filters', [rt.new_string('woocommerce_bacs_accounts'), this.account_details, rt.new_string(order_id)])
	if !(!rt.is_true(var_bacs_accounts)) {
		mut var_account_html := rt.new_string(rt.new_string(''))
		mut var_has_details := rt.new_bool(rt.new_bool(false))
		{
			mut iter_1 := var_bacs_accounts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_bacs_account := item_1.val
				var_bacs_account = // unsupported expression: Expr_Cast_Object
				if rt.is_true(rt.get_property(var_bacs_account, 'account_name')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				// unsupported expression: Expr_AssignOp_Concat
				mut var_account_fields := rt.call_function('apply_filters', [rt.new_string('woocommerce_bacs_account_fields'), rt.create_array([rt.ArrayItem{ key: 'bank_name', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Bank'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_bacs_account, 'bank_name') }]) }, rt.ArrayItem{ key: 'account_number', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Account number'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_bacs_account, 'account_number') }]) }, rt.ArrayItem{ key: 'sort_code', val: rt.create_array([rt.ArrayItem{ key: 'label', val: var_sortcode }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_bacs_account, 'sort_code') }]) }, rt.ArrayItem{ key: 'iban', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('IBAN'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_bacs_account, 'iban') }]) }, rt.ArrayItem{ key: 'bic', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('BIC'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.get_property(var_bacs_account, 'bic') }]) }]), rt.new_string(order_id)])
				{
					mut iter_2 := var_account_fields.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_field := item_2.val
						mut var_field_key := item_2.key
						if !(!rt.is_true(var_field.array_get('value'))) {
							// unsupported expression: Expr_AssignOp_Concat
							var_has_details = rt.new_bool(rt.new_bool(true))
						}
					}
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		if rt.is_true(var_has_details) {
			print('<section class="woocommerce-bacs-bank-details"><h2 class="wc-bacs-bank-details-heading">' + (rt.call_function('esc_html__', [rt.new_string('Our bank details'), rt.new_string('woocommerce')])).str() + '</h2>' + (rt.call_function('wp_kses_post', [rt.concat(rt.get_constant('PHP_EOL'), var_account_html)])).str() + '</section>')
		}
	}
}

fn (mut this Class_WC_Gateway_BACS) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.greater(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.new_int(0))) {
		mut var_process_payment_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_bacs_process_payment_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), var_order.dup()])
		rt.call_method(var_order, 'update_status', [var_process_payment_status.dup(), rt.call_function('__', [rt.new_string('Awaiting BACS payment.'), rt.new_string('woocommerce')])])
	} else {
		rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'result', val: 'success' }, rt.ArrayItem{ key: 'redirect', val: this.get_return_url(var_order.dup()) }])
}

fn (mut this Class_WC_Gateway_BACS) get_country_locale() rt.PhpVal {
	if !rt.is_true(this.locale) {
		this.locale = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_bacs_locale'), rt.create_array([rt.ArrayItem{ key: 'AU', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'CA', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'IN', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'IT', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'NZ', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'SE', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'US', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'ZA', val: rt.create_array([rt.ArrayItem{ key: 'sortcode', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }])])
	}
	return this.locale
}

fn (mut this Class_WC_Gateway_BACS) get_settings_url() rt.PhpVal {
	mut var_should_use_react_settings_page := rt.new_bool(this.is_reactified_settings_page())
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.wc_payments_settings_url(arg_0, arg_1) }(if rt.is_true(var_should_use_react_settings_page) {  + ().str() } else { rt.new_null() }, if rt.is_true(var_should_use_react_settings_page) { []rt.PhpVal{} } else { rt.create_array([rt.ArrayItem{ key: , val:  }]) })
}

fn (mut this Class_WC_Gateway_BACS) is_reactified_settings_page() bool {
	mut var_payments_settings_page := rt.new_null()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.get_settings_pages() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_settings_page := item_1.val
			if rt.is_true() {
			}
		}
	}
	if !rt.is_true() {
	}
	return ().to_bool()
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

fn create_wc_gateway_bacs() &Class_WC_Gateway_BACS {
	mut obj := &Class_WC_Gateway_BACS{
		PhpObjectBase: rt.PhpObjectBase{}
		locale: rt.new_null()
		instructions: rt.new_null()
		account_details: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_payment_gateway() &Class_WC_Payment_Gateway {
	mut obj := &Class_WC_Payment_Gateway{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_settings_utils() &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Gateway_BACS) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'generate_account_details_html' {
			return this.generate_account_details_html()
		}
		'save_account_details' {
			this.save_account_details()
			return rt.new_null()
		}
		'thankyou_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.thankyou_page(dispatch_arg_0)
			return rt.new_null()
		}
		'email_instructions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_instructions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'bank_details' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.bank_details(dispatch_arg_0)
			return rt.new_null()
		}
		'process_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_payment(dispatch_arg_0)
		}
		'get_country_locale' {
			return this.get_country_locale()
		}
		'get_settings_url' {
			return this.get_settings_url()
		}
		'is_reactified_settings_page' {
			return rt.new_bool(this.is_reactified_settings_page())
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_BACS) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'locale' { return this.locale }
		'instructions' { return this.instructions }
		'account_details' { return this.account_details }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_BACS) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'locale' { this.locale = val; return true }
		'instructions' { this.instructions = val; return true }
		'account_details' { this.account_details = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_gateways_bacs_class_wc_gateway_bacs_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
