import rt

pub fn Class_WC_Gateway_Cheque.id() string {
	return 'cheque'
}
struct Class_WC_Gateway_Cheque {
	rt.PhpObjectBase
pub mut:
		instructions rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Gateway_Cheque) construct()  {
	this.dispatch_set_prop('id', Class_WC_Gateway_Cheque.id())
	this.dispatch_set_prop('icon', rt.call_function('apply_filters', [rt.new_string('woocommerce_cheque_icon'), rt.new_string('')]))
	this.dispatch_set_prop('has_fields', rt.new_bool(false))
	this.dispatch_set_prop('method_title', rt.call_function('_x', [rt.new_string('Check payments'), rt.new_string('Check payment method'), rt.new_string('woocommerce')]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [rt.new_string('Take payments in person via checks. This offline gateway can also be useful to test purchases.'), rt.new_string('woocommerce')]))
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('description', this.get_option(rt.new_string('description')))
	this.instructions = this.get_option(rt.new_string('instructions'))
	rt.call_function('add_action', ['woocommerce_update_options_payment_gateways_' + (rt.get_property(rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this), 'id')).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'process_admin_options' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_thankyou_cheque'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'thankyou_page' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_email_before_order_table'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this) }, rt.ArrayItem{ key: none, val: 'email_instructions' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_WC_Gateway_Cheque) init_form_fields()  {
	this.dispatch_set_prop('form_fields', rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enable/Disable'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enable check payments'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: 'no' }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'safe_text' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This controls the title which the user sees during checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('_x', [rt.new_string('Check payments'), rt.new_string('Check payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Description'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Payment method description that the customer will see on your checkout.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('__', [rt.new_string('Please send a check to Store Name, Store Street, Store Town, Store State / County, Store Postcode.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }, rt.ArrayItem{ key: 'instructions', val: rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Instructions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'textarea' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Instructions that will be added to the thank you page and emails.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'desc_tip', val: true }]) }]))
}

fn (mut this Class_WC_Gateway_Cheque) thankyou_page()  {
	if rt.is_true(this.instructions) {
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('wptexturize', [this.instructions])])]))
	}
}

fn (mut this Class_WC_Gateway_Cheque) email_instructions(var_order rt.PhpVal, var_sent_to_admin rt.PhpVal, plain_text bool)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.instructions) && rt.is_true(rt.new_bool(!(rt.is_true(var_sent_to_admin)))))) && rt.is_true(rt.identical(Class_WC_Gateway_Cheque.id(), rt.call_method(var_order_mutated, 'get_payment_method', []rt.PhpVal{}))))) {
		mut var_instructions_order_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_cheque_email_instructions_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), var_order_mutated.dup()])
		if rt.is_true(rt.call_method(var_order_mutated, 'has_status', [var_instructions_order_status.dup()])) {
			rt.echo_val(rt.call_function('wp_kses_post', [rt.concat(rt.call_function('wpautop', [rt.call_function('wptexturize', [this.instructions])]), rt.get_constant('PHP_EOL'))]))
		}
	}
}

fn (mut this Class_WC_Gateway_Cheque) process_payment(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.dup()])
	if rt.is_true(rt.greater(rt.call_method(var_order, 'get_total', []rt.PhpVal{}), rt.new_int(0))) {
		mut var_process_payment_status := rt.call_function('apply_filters', [rt.new_string('woocommerce_cheque_process_payment_order_status'), Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold(), var_order.dup()])
		rt.call_method(var_order, 'update_status', [var_process_payment_status.dup(), rt.call_function('_x', [rt.new_string('Awaiting check payment.'), rt.new_string('Check payment method'), rt.new_string('woocommerce')])])
	} else {
		rt.call_method(var_order, 'payment_complete', []rt.PhpVal{})
	}
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'empty_cart', []rt.PhpVal{})
	return rt.create_array([rt.ArrayItem{ key: 'result', val: 'success' }, rt.ArrayItem{ key: 'redirect', val: this.get_return_url(var_order.dup()) }])
}

fn (mut this Class_WC_Gateway_Cheque) get_settings_url() rt.PhpVal {
	mut var_payments_settings_page := rt.new_null()
	{
		mut iter_1 := fn () rt.PhpVal { mut temp := Class_WC_Admin_Settings{}; return temp.get_settings_pages() }().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_settings_page := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_settings_page, 'WC_Settings_Payment_Gateways'))) {
				var_payments_settings_page = var_settings_page
				break
			}
		}
	}
	if !rt.is_true(var_payments_settings_page) {
		return fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.wc_payments_settings_url(arg_0) }(rt.new_string('/' + (Class_WC_Settings_Payment_Gateways.offline_section_name()).str() + '/' + (rt.get_property(rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this), 'id')).str()))
	}
	mut var_should_use_react_settings_page := rt.call_method(var_payments_settings_page, 'should_render_react_section', [Class_WC_Settings_Payment_Gateways.cheque_section_name()])
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils{}; return temp.wc_payments_settings_url(arg_0, arg_1) }(if rt.is_true(var_should_use_react_settings_page) { '/' + (Class_WC_Settings_Payment_Gateways.offline_section_name()).str() + '/' + (rt.get_property(rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this), 'id')).str() } else { rt.new_null() }, if rt.is_true(var_should_use_react_settings_page) { rt.new_array() } else { rt.create_array([rt.ArrayItem{ key: 'section', val: rt.get_property(rt.new_object('WC_Gateway_Cheque', ['WC_Payment_Gateway'], &this), 'id') }]) })
}

struct Class_WC_Payment_Gateway {
	rt.PhpObjectBase
}

struct Class_WC_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Settings_Utils {
	rt.PhpObjectBase
}

fn create_wc_gateway_cheque() &Class_WC_Gateway_Cheque {
	mut obj := &Class_WC_Gateway_Cheque{
		PhpObjectBase: rt.PhpObjectBase{}
		instructions: rt.new_null()
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

fn create_wc_admin_settings() &Class_WC_Admin_Settings {
	mut obj := &Class_WC_Admin_Settings{
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

fn (mut this Class_WC_Gateway_Cheque) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'thankyou_page' {
			this.thankyou_page()
			return rt.new_null()
		}
		'email_instructions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.email_instructions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'process_payment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process_payment(dispatch_arg_0)
		}
		'get_settings_url' {
			return this.get_settings_url()
		}
		else { return none }
	}
}

fn (this &Class_WC_Gateway_Cheque) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instructions' { return this.instructions }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Gateway_Cheque) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instructions' { this.instructions = val; return true }
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


fn (mut this Class_WC_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_includes_gateways_cheque_class_wc_gateway_cheque_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
