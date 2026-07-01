import rt

struct Class_WC_Shipping_Legacy_Free_Shipping {
	rt.PhpObjectBase
pub mut:
	min_amount rt.PhpVal = rt.new_null()
	requires   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) construct() {
	this.dispatch_set_prop('id', rt.new_string('legacy_free_shipping'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Free shipping (legacy)'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', '<strong>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This method is deprecated in 2.6.0 and will be removed in future versions - we recommend disabling it and instead setting up a new rate within your <a href="%s">Shipping zones</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])).str() +
		'</strong>')
	this.init()
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) process_admin_options() {
	this.Class_WC_Shipping_Method.process_admin_options()
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
		'WC_Shipping_Method',
	], &this), 'settings').array_get('enabled')))
	{
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=shipping&section=options'),
			]),
		])
		// unsupported expression: Expr_Exit
	}
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) get_option_key() string {
	return
		(rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', ['WC_Shipping_Method'], &this), 'plugin_id')).str() +
		'free_shipping_settings'
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) init() {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('enabled', this.get_option(rt.new_string('enabled')))
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.min_amount = this.get_option(rt.new_string('min_amount'), rt.new_int(0))
	this.dispatch_set_prop('availability', this.get_option(rt.new_string('availability')))
	this.dispatch_set_prop('countries', this.get_option(rt.new_string('countries')))
	this.requires = this.get_option(rt.new_string('requires'))
	rt.call_function('add_action', [
		'woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', ['WC_Shipping_Method'], &this), 'id'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.create_array([
		rt.ArrayItem{ key: 'enabled', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Once disabled, this legacy method will no longer be available.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: 'no' },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Method title'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('This controls the title which the user sees during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.call_function('__', [
				rt.new_string('Free Shipping'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: 'availability', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Method availability'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'default', val: 'all' },
			rt.ArrayItem{ key: 'class', val: 'availability wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'all', val: rt.call_function('__', [
					rt.new_string('All allowed countries'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'specific', val: rt.call_function('__', [
					rt.new_string('Specific Countries'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'countries', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Specific countries'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'multiselect' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'css', val: 'width: 400px;' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'options', val: rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'data-placeholder', val: rt.call_function('__', [
					rt.new_string('Select some countries'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'requires', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Free shipping requires...'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: '', val: rt.call_function('__', [
					rt.new_string('N/A'),
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
					rt.new_string('A minimum order amount OR a coupon'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'both', val: rt.call_function('__', [
					rt.new_string('A minimum order amount AND a coupon'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'min_amount', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Minimum order amount'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'price' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_price', [
				rt.new_int(0),
			]) },
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Users will need to spend this amount to get free shipping (if enabled above).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '0' },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
	]))
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) is_available(var_package rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
		'WC_Shipping_Method',
	], &this), 'enabled')))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('specific'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
		'WC_Shipping_Method',
	], &this), 'availability')))
	{
		mut var_ship_to_countries := rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
			'WC_Shipping_Method',
		], &this), 'countries')
	} else {
		var_ship_to_countries = rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_ship_to_countries.dup().is_array()))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_package.array_get('destination').array_get('country'), var_ship_to_countries.dup(), rt.new_bool(true)])))))))
	{
		return false
	}
	mut var_is_available := rt.new_bool(rt.new_bool(false))
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
		if rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'),
			'display_prices_including_tax', []rt.PhpVal{}))
		{
			var_total = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				return temp.round(arg_0, arg_1)
			}(rt.sub(var_total, rt.add(rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'get_discount_total', []rt.PhpVal{}), rt.call_method(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'get_discount_tax', []rt.PhpVal{}))), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}))
		} else {
			var_total = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
				return temp.round(arg_0, arg_1)
			}(rt.sub(var_total, rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'get_discount_total', []rt.PhpVal{})), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}))
		}
		if rt.is_true(rt.greater_equal(var_total, this.min_amount)) {
			var_has_met_min_amount = rt.new_bool(rt.new_bool(true))
		}
	}
	mut switch_val_1 := this.requires
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('min_amount'))) {
		if rt.is_true(var_has_met_min_amount) {
			var_is_available = rt.new_bool(rt.new_bool(true))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon'))) {
		if rt.is_true(var_has_coupon) {
			var_is_available = rt.new_bool(rt.new_bool(true))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('both'))) {
		if rt.is_true(rt.new_bool(rt.is_true(var_has_met_min_amount) && rt.is_true(var_has_coupon))) {
			var_is_available = rt.new_bool(rt.new_bool(true))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('either'))) {
		if rt.is_true(rt.new_bool(rt.is_true(var_has_met_min_amount) || rt.is_true(var_has_coupon))) {
			var_is_available = rt.new_bool(rt.new_bool(true))
		}
	} else {
		var_is_available = rt.new_bool(rt.new_bool(true))
	}
	return (rt.call_function('apply_filters', [
		'woocommerce_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', ['WC_Shipping_Method'], &this), 'id') +
			'_is_available',
		var_is_available.dup(),
		var_package.dup(),
		rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
			'WC_Shipping_Method',
		], &this),
	])).to_bool()
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) calculate_shipping(var_package rt.PhpVal) {
	mut var_args := {
		'id':      rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
			'WC_Shipping_Method',
		], &this), 'id')
		'label':   rt.get_property(rt.new_object('WC_Shipping_Legacy_Free_Shipping', [
			'WC_Shipping_Method',
		], &this), 'title')
		'cost':    rt.new_int(0)
		'taxes':   rt.new_bool(false)
		'package': var_package
	}
	this.add_rate(var_args.dup())
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

fn create_wc_shipping_legacy_free_shipping() &Class_WC_Shipping_Legacy_Free_Shipping {
	mut obj := &Class_WC_Shipping_Legacy_Free_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
		min_amount:    rt.new_null()
		requires:      rt.new_null()
	}
	obj.construct()
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

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'process_admin_options' {
			this.process_admin_options()
			return rt.new_null()
		}
		'get_option_key' {
			return rt.new_string(this.get_option_key())
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_available(dispatch_arg_0))
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Legacy_Free_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'min_amount' { return this.min_amount }
		'requires' { return this.requires }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Legacy_Free_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'min_amount' {
			this.min_amount = val
			return true
		}
		'requires' {
			this.requires = val
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

pub fn init_wp_content_plugins_woocommerce_includes_shipping_legacy_free_shipping_class_wc_shipping_legacy_free_shipping_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
