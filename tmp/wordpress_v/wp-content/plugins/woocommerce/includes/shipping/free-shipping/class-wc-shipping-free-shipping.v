import rt

struct Class_WC_Shipping_Free_Shipping {
	rt.PhpObjectBase
pub mut:
	min_amount       rt.PhpVal = rt.new_int(0)
	requires         rt.PhpVal = rt.new_string('')
	ignore_discounts rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Free_Shipping) construct(instance_id i64) {
	this.dispatch_set_prop('id', rt.new_string('free_shipping'))
	this.dispatch_set_prop('instance_id', rt.call_function('absint', [
		rt.new_int(instance_id),
	]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Free shipping'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [
		rt.new_string('Free shipping is a special method which can be triggered with coupons and minimum spends.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('supports', rt.create_array([
		rt.ArrayItem{ key: none, val: 'shipping-zones' },
		rt.ArrayItem{ key: none, val: 'instance-settings' },
		rt.ArrayItem{ key: none, val: 'instance-settings-modal' },
	]))
	this.init()
}

fn (mut this Class_WC_Shipping_Free_Shipping) init() {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.min_amount = this.get_option(rt.new_string('min_amount'), rt.new_int(0))
	this.requires = this.get_option(rt.new_string('requires'))
	this.ignore_discounts = this.get_option(rt.new_string('ignore_discounts'))
	rt.call_function('add_action', [
		'woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Free_Shipping', ['WC_Shipping_Method'], &this), 'id'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Free_Shipping', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('admin_footer'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Shipping_Free_Shipping' },
			rt.ArrayItem{ key: none, val: 'enqueue_admin_js' }]),
		rt.new_int(10)])
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Shipping_Free_Shipping) sanitize_cost(var_value rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		return temp.sanitize_cost_in_current_locale(arg_0)
	}(var_value.dup())
}

fn (mut this Class_WC_Shipping_Free_Shipping) init_form_fields() {
	this.dispatch_set_prop('instance_form_fields', rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Your customers will see the name of this shipping method during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.get_property(rt.new_object('WC_Shipping_Free_Shipping', [
				'WC_Shipping_Method',
			], &this), 'method_title') },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('e.g. Free shipping'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'requires', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Free shipping requires'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('No requirement'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'coupon', val: rt.call_function('__', [
					rt.new_string('A valid free shipping coupon'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'min_amount', val: rt.call_function('__', [
					rt.new_string('A minimum order amount'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'either', val: rt.call_function('__', [
					rt.new_string('A minimum order amount OR coupon'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'both', val: rt.call_function('__', [
					rt.new_string('A minimum order amount AND coupon'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'min_amount', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Minimum order amount'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'class', val: 'wc-shipping-modal-price' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_price', [
				rt.new_int(0),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Customers will need to spend this amount to get free shipping.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '0' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
			rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Free_Shipping', [
					'WC_Shipping_Method',
				], &this) },
				rt.ArrayItem{ key: none, val: 'sanitize_cost' },
			]) },
		]) },
		rt.ArrayItem{ key: 'ignore_discounts', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Coupons discounts'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Apply minimum order rule before coupon discount'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('If checked, free shipping would be available based on pre-discount order amount.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
	]))
}

fn (mut this Class_WC_Shipping_Free_Shipping) get_instance_form_fields() rt.PhpVal {
	return this.Class_WC_Shipping_Method.get_instance_form_fields()
}

fn (mut this Class_WC_Shipping_Free_Shipping) is_available(var_package rt.PhpVal) rt.PhpVal {
	mut var_has_coupon := rt.new_bool(rt.new_bool(false))
	mut var_has_met_min_amount := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.call_function('in_array', [this.requires,
		rt.create_array([rt.ArrayItem{ key: none, val: 'coupon' },
			rt.ArrayItem{ key: none, val: 'either' }, rt.ArrayItem{ key: none, val: 'both' }]),
		rt.new_bool(true)]))
	{
		mut var_coupons := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'cart'), 'get_coupons', []rt.PhpVal{})
		if rt.is_true(var_coupons) {
			{
				mut iter_1 := var_coupons.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_coupon := item_1.val
					mut var_code := item_1.key
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.call_method(var_coupon, 'is_valid', []rt.PhpVal{}))
						&& rt.is_true(rt.call_method(var_coupon, 'get_free_shipping', []rt.PhpVal{}))))
					{
						var_has_coupon = rt.new_bool(rt.new_bool(true))
						break
					}
				}
			}
		}
	}
	if rt.is_true(rt.call_function('in_array', [this.requires,
		rt.create_array([rt.ArrayItem{ key: none, val: 'min_amount' },
			rt.ArrayItem{ key: none, val: 'either' }, rt.ArrayItem{ key: none, val: 'both' }]),
		rt.new_bool(true)]))
	{
		mut var_total := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'cart'), 'get_displayed_subtotal', []rt.PhpVal{})
		if rt.is_true(rt.identical(rt.new_string('no'), this.ignore_discounts)) {
			var_total = rt.sub(var_total, rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'get_discount_total', []rt.PhpVal{}))
			if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'display_prices_including_tax', []rt.PhpVal{}))
			{
				var_total = rt.sub(var_total, rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'cart'), 'get_discount_tax', []rt.PhpVal{}))
			}
		}
		var_total = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
			return temp.round(arg_0, arg_1)
		}(var_total.dup(), rt.call_function('wc_get_price_decimals', []rt.PhpVal{}))
		if rt.is_true(rt.greater_equal(var_total, this.min_amount)) {
			var_has_met_min_amount = rt.new_bool(rt.new_bool(true))
		}
	}
	mut switch_val_1 := this.requires
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('min_amount'))) {
		mut var_is_available := var_has_met_min_amount.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon'))) {
		var_is_available = var_has_coupon.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('both'))) {
		var_is_available = rt.new_bool(rt.new_bool(rt.is_true(var_has_met_min_amount)
			&& rt.is_true(var_has_coupon)))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('either'))) {
		var_is_available = rt.new_bool(rt.new_bool(rt.is_true(var_has_met_min_amount)
			|| rt.is_true(var_has_coupon)))
	} else {
		var_is_available = rt.new_bool(rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [
		'woocommerce_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Free_Shipping', ['WC_Shipping_Method'], &this), 'id') +
			'_is_available',
		var_is_available.dup(),
		var_package.dup(),
		rt.new_object('WC_Shipping_Free_Shipping', [
			'WC_Shipping_Method',
		], &this),
	])
}

fn (mut this Class_WC_Shipping_Free_Shipping) calculate_shipping(var_package rt.PhpVal) {
	this.add_rate(rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.get_property(rt.new_object('WC_Shipping_Free_Shipping', [
			'WC_Shipping_Method',
		], &this), 'title') },
		rt.ArrayItem{ key: 'cost', val: 0 },
		rt.ArrayItem{ key: 'taxes', val: false },
		rt.ArrayItem{ key: 'package', val: var_package },
	]))
}

fn Class_WC_Shipping_Free_Shipping.enqueue_admin_js() {
	mut var_handle := rt.new_string(rt.new_string('wc-admin-shipping-free-shipping'))
	rt.call_function('wp_register_script', [var_handle.dup(),
		rt.new_string(''), rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
		rt.get_constant('WC_VERSION'), rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.dup()])
	rt.call_function('wp_add_inline_script', [var_handle.dup(),
		rt.new_string("jQuery( function( $ ) {\n\t\t\t\tfunction wcFreeShippingShowHideMinAmountField( el ) {\n\t\t\t\t\tconst form = $( el ).closest( 'form' );\n\t\t\t\t\tconst minAmountField = $( '#woocommerce_free_shipping_min_amount', form ).closest( 'tr' );\n\t\t\t\t\tconst ignoreDiscountField = $( '#woocommerce_free_shipping_ignore_discounts', form ).closest( 'tr' );\n\t\t\t\t\tif ( 'coupon' === $( el ).val() || '' === $( el ).val() ) {\n\t\t\t\t\t\tminAmountField.hide();\n\t\t\t\t\t\tignoreDiscountField.hide();\n\t\t\t\t\t} else {\n\t\t\t\t\t\tminAmountField.show();\n\t\t\t\t\t\tignoreDiscountField.show();\n\t\t\t\t\t}\n\t\t\t\t}\n\n\t\t\t\t$( document.body ).on( 'change', '#woocommerce_free_shipping_requires', function() {\n\t\t\t\t\twcFreeShippingShowHideMinAmountField( this );\n\t\t\t\t});\n\n\t\t\t\t// Change while load.\n\t\t\t\t$( '#woocommerce_free_shipping_requires' ).trigger( 'change' );\n\t\t\t\t$( document.body ).on( 'wc_backbone_modal_loaded', function( evt, target ) {\n\t\t\t\t\tif ( 'wc-modal-shipping-method-settings' === target ) {\n\t\t\t\t\t\twcFreeShippingShowHideMinAmountField( $( '#wc-backbone-modal-dialog #woocommerce_free_shipping_requires', evt.currentTarget ) );\n\t\t\t\t\t}\n\t\t\t\t} );\n\t\t\t});")])
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn create_wc_shipping_free_shipping(instance_id i64) &Class_WC_Shipping_Free_Shipping {
	mut obj := &Class_WC_Shipping_Free_Shipping{
		PhpObjectBase:    rt.PhpObjectBase{}
		min_amount:       rt.new_int(0)
		requires:         rt.new_string('')
		ignore_discounts: rt.new_null()
	}
	obj.construct(instance_id)
	return obj
}

fn create_wc_shipping_method() &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Free_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'sanitize_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_cost(dispatch_arg_0)
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'get_instance_form_fields' {
			return this.get_instance_form_fields()
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_available(dispatch_arg_0)
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue_admin_js' {
			Class_WC_Shipping_Free_Shipping.enqueue_admin_js()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Free_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'min_amount' { return this.min_amount }
		'requires' { return this.requires }
		'ignore_discounts' { return this.ignore_discounts }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Free_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'min_amount' {
			this.min_amount = val
			return true
		}
		'requires' {
			this.requires = val
			return true
		}
		'ignore_discounts' {
			this.ignore_discounts = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Shipping_Method) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Method) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Method) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_includes_shipping_free_shipping_class_wc_shipping_free_shipping_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
