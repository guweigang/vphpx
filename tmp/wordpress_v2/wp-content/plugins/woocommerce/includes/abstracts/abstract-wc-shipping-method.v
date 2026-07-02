import rt

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
pub mut:
	supports             rt.PhpVal = rt.new_array()
	id                   rt.PhpVal = rt.new_string('')
	method_title         rt.PhpVal = rt.new_string('')
	method_description   rt.PhpVal = rt.new_string('')
	enabled              rt.PhpVal = rt.new_string('yes')
	title                rt.PhpVal = rt.new_null()
	rates                rt.PhpVal = rt.new_array()
	tax_status           rt.PhpVal = rt.new_null()
	fee                  rt.PhpVal = rt.new_null()
	minimum_fee          rt.PhpVal = rt.new_null()
	instance_id          rt.PhpVal = rt.new_int(0)
	instance_form_fields rt.PhpVal = rt.new_array()
	instance_settings    rt.PhpVal = rt.new_array()
	availability         rt.PhpVal = rt.new_null()
	countries            rt.PhpVal = rt.new_array()
	method_order         rt.PhpVal = rt.new_null()
	has_settings         rt.PhpVal = rt.new_null()
	settings_html        rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Method) construct(instance_id i64) {
	this.instance_id = rt.call_function('absint', [rt.new_int(instance_id)])
}

fn (mut this Class_WC_Shipping_Method) supports(var_feature rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_supports'),
		rt.call_function('in_array', [var_feature.clone(), this.supports]),
		var_feature.clone(),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Shipping_Method) calculate_shipping(var_package rt.PhpVal) {
}

fn (mut this Class_WC_Shipping_Method) is_taxable() bool {
	return rt.is_true(rt.call_function('wc_tax_enabled', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable(), this.tax_status))
		&& rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'customer'), 'get_is_vat_exempt', []rt.PhpVal{})))))
}

fn (mut this Class_WC_Shipping_Method) is_enabled() rt.PhpVal {
	return rt.identical(rt.new_string('yes'), this.enabled)
}

fn (mut this Class_WC_Shipping_Method) get_instance_id() rt.PhpVal {
	return this.instance_id
}

fn (mut this Class_WC_Shipping_Method) get_method_title() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_title'),
		this.method_title,
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Shipping_Method) get_method_description() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_description'),
		this.method_description,
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Shipping_Method) get_title() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_title'),
		this.title,
		this.id,
	])
}

fn (mut this Class_WC_Shipping_Method) get_rates_for_package(var_package rt.PhpVal) rt.PhpVal {
	this.rates = rt.new_array()
	if rt.is_true(this.is_available(var_package.clone()))
		&& !rt.is_true(var_package.array_get(rt.new_string('ship_via')))
		|| rt.is_true(rt.call_function('in_array', [this.id, var_package.array_get(rt.new_string('ship_via'))])) {
		this.calculate_shipping(var_package.clone())
	}
	return this.rates
}

fn (mut this Class_WC_Shipping_Method) get_rate_id(suffix string) rt.PhpVal {
	mut var_rate_id := [this.id]
	if rt.is_true(this.instance_id) {
		var_rate_id << this.instance_id
	}
	if var_suffix.len > 0 && var_suffix != '0' {
		var_rate_id << rt.new_string(suffix)
	}
	return rt.call_function('implode', [rt.new_string(':'), rt.create_array_from_list(var_rate_id)])
}

fn (mut this Class_WC_Shipping_Method) add_rate(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_add_rate_args'),
		rt.call_function('wp_parse_args', [var_args_mutated.clone(),
			rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_rate_id('') },
				rt.ArrayItem{ key: 'label', val: '' }, rt.ArrayItem{ key: 'cost', val: '0' },
				rt.ArrayItem{ key: 'taxes', val: '' }, rt.ArrayItem{
					key: 'calc_tax'
					val: 'per_order'
				}, rt.ArrayItem{ key: 'meta_data', val: rt.new_array() },
				rt.ArrayItem{ key: 'package', val: false }, rt.ArrayItem{
					key: 'price_decimals'
					val: false
				}])]),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('id'))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('label')))))) {
		return
	}
	mut var_total_cost := if var_args_mutated.array_get(rt.new_string('cost')).is_array() { rt.call_function('array_sum', [
			var_args_mutated.array_get(rt.new_string('cost')),
		]) } else { var_args_mutated.array_get(rt.new_string('cost')) }
	mut var_taxes := var_args_mutated.array_get(rt.new_string('taxes'))
	if !(var_taxes.clone().is_array())
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_taxes))))
		&& rt.is_true(rt.greater(var_total_cost, rt.new_int(0))) && this.is_taxable() {
		if rt.is_true(rt.identical(rt.new_string('per_item'),
			var_args_mutated.array_get(rt.new_string('calc_tax'))))
		{
			var_taxes = this.get_taxes_per_item(var_args_mutated.array_get(rt.new_string('cost')))
		} else {
			mut iife_temp_0 := Class_WC_Tax{}
			mut iife_result_0 := iife_temp_0.get_shipping_tax_rates()
			mut var_shipping_tax_rates := iife_result_0
			mut iife_temp_1 := Class_WC_Tax{}
			mut iife_result_1 := iife_temp_1.calc_shipping_tax(var_total_cost.clone(),
				var_shipping_tax_rates.clone())
			var_taxes = iife_result_1
		}
		mut var_shipping_prices_include_tax := rt.call_function('wc_string_to_bool', [
			rt.call_function('apply_filters', [
				rt.new_string('woocommerce_shipping_prices_include_tax'),
				rt.new_bool(false),
			]),
		])
		if rt.is_true(var_shipping_prices_include_tax) && !(!rt.is_true(var_taxes)) {
			var_total_cost = rt.sub(var_total_cost, rt.call_function('array_sum', [
				var_taxes.clone(),
			]))
		}
	}
	var_total_cost = rt.call_function('wc_format_decimal', [var_total_cost.clone(),
		var_args_mutated.array_get(rt.new_string('price_decimals'))])
	if rt.is_true(rt.identical(rt.new_string(''), var_total_cost)) {
		var_total_cost = rt.new_string('0')
	}
	mut var_rate := create_wc_shipping_rate()
	var_rate.set_id(var_args_mutated.array_get(rt.new_string('id')))
	var_rate.set_method_id(this.id)
	var_rate.set_instance_id(this.instance_id)
	var_rate.set_label(var_args_mutated.array_get(rt.new_string('label')))
	var_rate.set_cost(var_total_cost.clone())
	var_rate.set_taxes(var_taxes.clone())
	var_rate.set_tax_status(this.tax_status)
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('meta_data')))) {
		mut iter_1 := var_args_mutated.array_get(rt.new_string('meta_data')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_rate.add_meta_data(var_key.clone(), var_value.clone())
		}
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('package'))) {
		mut var_items_in_package := rt.new_array()
		mut iter_2 :=
			var_args_mutated.array_get(rt.new_string('package')).array_get(rt.new_string('contents')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_item := item_2.val
			mut var_product := var_item.array_get(rt.new_string('data'))
			var_items_in_package <<
				(rt.call_method(var_product, 'get_name', []rt.PhpVal{})).str() + ' &times; ' +
				(var_item.array_get(rt.new_string('quantity'))).str()
		}
		var_rate.add_meta_data(rt.call_function('__', [rt.new_string('Items'),
			rt.new_string('woocommerce')]), rt.call_function('implode', [
			rt.new_string(', '),
			rt.create_array_from_list(var_items_in_package),
		]))
	}
	this.rates.array_set(var_args_mutated.array_get(rt.new_string('id')), rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_method_add_rate'),
		var_rate,
		var_args_mutated.clone(),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	]))
}

fn (mut this Class_WC_Shipping_Method) get_taxes_per_item(var_costs rt.PhpVal) rt.PhpVal {
	mut var_taxes := rt.new_array()
	if rt.is_true(rt.new_bool(var_costs.clone().is_array())) {
		mut var_cart := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
			'cart'), 'get_cart', []rt.PhpVal{})
		mut iter_3 := var_costs.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_amount := item_3.val
			mut var_cost_key := item_3.key
			if !(var_cart.array_isset(var_cost_key)) {
				continue
			}
			mut var_cart_item_data :=
				var_cart.array_get(var_cost_key).array_get(rt.new_string('data'))
			if var_cart_item_data.clone().is_object()
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_cart_item_data
			}, rt.ArrayItem{ key: none, val: 'get_tax_class' }])]) {
				mut var_tax_class := rt.call_method(var_cart_item_data, 'get_tax_class',
					[]rt.PhpVal{})
			} else {
				var_tax_class = rt.new_null()
			}
			mut iife_temp_2 := Class_WC_Tax{}
			mut iife_result_2 := iife_temp_2.get_shipping_tax_rates(var_tax_class.clone())
			mut var_item_tax_rates := iife_result_2
			mut iife_temp_3 := Class_WC_Tax{}
			mut iife_result_3 := iife_temp_3.calc_shipping_tax(var_amount.clone(),
				var_item_tax_rates.clone())
			mut var_item_taxes := iife_result_3
			mut iter_4 := rt.func_array_keys(rt.add(var_taxes, var_item_taxes)).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_key := item_4.val
				var_taxes.array_set(var_key, rt.add(if var_item_taxes.array_isset(var_key) {
					var_item_taxes.array_get(var_key)
				} else {
					rt.new_int(0)
				}, if var_taxes.array_isset(var_key) {
					var_taxes.array_get(var_key)
				} else {
					rt.new_int(0)
				}))
			}
		}
		if var_costs.array_isset(rt.new_string('order')) {
			mut iife_temp_4 := Class_WC_Tax{}
			mut iife_result_4 := iife_temp_4.get_shipping_tax_rates()
			mut var_order_tax_rates := iife_result_4
			mut iife_temp_5 := Class_WC_Tax{}
			mut iife_result_5 := iife_temp_5.calc_shipping_tax(var_costs.array_get(rt.new_string('order')),
				var_order_tax_rates.clone())
			mut var_item_taxes := iife_result_5
			mut iter_5 := rt.func_array_keys(rt.add(var_taxes, var_item_taxes)).iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_key := item_5.val
				var_taxes.array_set(var_key, rt.add(if var_item_taxes.array_isset(var_key) {
					var_item_taxes.array_get(var_key)
				} else {
					rt.new_int(0)
				}, if var_taxes.array_isset(var_key) {
					var_taxes.array_get(var_key)
				} else {
					rt.new_int(0)
				}))
			}
		}
	}
	return var_taxes.clone()
}

fn (mut this Class_WC_Shipping_Method) is_available(var_package rt.PhpVal) rt.PhpVal {
	mut var_available := this.is_enabled()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.instance_id)))) && rt.is_true(var_available) {
		mut var_countries := if this.countries.is_array() { this.countries } else { rt.new_array() }
		mut switch_val_1 := this.availability
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('specific')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('including'))) {
			var_available = rt.call_function('in_array', [
				var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country')),
				rt.call_function('array_intersect', [var_countries.clone(),
					rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC',
						[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{}))]),
			])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('excluding'))) {
			var_available = rt.call_function('in_array', [
				var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country')),
				rt.call_function('array_diff', [
					rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC',
						[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})),
					var_countries.clone(),
				]),
			])
		} else {
			var_available = rt.call_function('in_array', [
				var_package.array_get(rt.new_string('destination')).array_get(rt.new_string('country')),
				rt.func_array_keys(rt.call_method(rt.get_property(rt.call_function('WC',
					[]rt.PhpVal{}), 'countries'), 'get_shipping_countries', []rt.PhpVal{})),
			])
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_' + (this.id).str() + '_is_available'),
		var_available.clone(),
		var_package.clone(),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
}

fn (mut this Class_WC_Shipping_Method) get_fee(var_fee rt.PhpVal, var_total rt.PhpVal) rt.PhpVal {
	mut var_fee_mutated := var_fee
	if rt.is_true(rt.call_function('strstr', [var_fee_mutated.clone(),
		rt.new_string('%')]))
	{
		var_fee_mutated = rt.mul(rt.div(var_total, rt.new_int(100)), rt.call_function('str_replace', [
			rt.new_string('%'),
			rt.new_string(''),
			var_fee_mutated.clone(),
		]))
	}
	if !(!rt.is_true(this.minimum_fee)) && rt.is_true(rt.greater(this.minimum_fee, var_fee_mutated)) {
		var_fee_mutated = this.minimum_fee
	}
	return var_fee_mutated.clone()
}

fn (mut this Class_WC_Shipping_Method) has_settings() rt.PhpVal {
	return if rt.is_true(this.instance_id) {
		this.supports(rt.new_string('instance-settings'))
	} else {
		this.supports(rt.new_string('settings'))
	}
}

fn (mut this Class_WC_Shipping_Method) get_admin_options_html() string {
	if rt.is_true(this.instance_id) {
		mut var_settings_html := this.generate_settings_html(this.get_instance_form_fields(),
			rt.new_bool(false))
	} else {
		var_settings_html = this.generate_settings_html(this.get_form_fields(), rt.new_bool(false))
	}
	return '<table class="form-table">' + var_settings_html.str() + '</table>'
}

fn (mut this Class_WC_Shipping_Method) admin_options() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.instance_id)))) {
		print('<h2>' + (rt.call_function('esc_html', [this.get_method_title()])).str() + '</h2>')
	}
	rt.echo_val(rt.call_function('wp_kses_post', [
		rt.call_function('wpautop', [this.get_method_description()]),
	]))
	print(this.get_admin_options_html())
}

fn (mut this Class_WC_Shipping_Method) get_option(var_key rt.PhpVal, var_empty_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(this.instance_id)
		&& rt.is_true(rt.new_bool(this.get_instance_form_fields().array_isset(var_key.clone()))) {
		return this.get_instance_option(var_key.clone(), var_empty_value.clone())
	}
	mut var_option := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_' + (this.id).str() + '_option'),
		this.Class_WC_Settings_API.get_option(var_key.clone(), var_empty_value.clone()),
		var_key.clone(),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
	return var_option.clone()
}

fn (mut this Class_WC_Shipping_Method) get_instance_option(var_key rt.PhpVal, var_empty_value rt.PhpVal) rt.PhpVal {
	if !rt.is_true(this.instance_settings) {
		this.init_instance_settings()
	}
	if !(this.instance_settings.array_isset(var_key)) {
		mut var_form_fields := this.get_instance_form_fields()
		this.instance_settings.array_set(var_key,
			this.get_field_default(var_form_fields.array_get(var_key)))
	}
	if !(var_empty_value.clone().is_null())
		&& rt.is_true(rt.identical(rt.new_string(''), this.instance_settings.array_get(var_key))) {
		this.instance_settings.array_set(var_key, var_empty_value.clone())
	}
	mut var_instance_option := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_' + (this.id).str() + '_instance_option'),
		this.instance_settings.array_get(var_key),
		var_key.clone(),
		rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
	])
	return var_instance_option.clone()
}

fn (mut this Class_WC_Shipping_Method) get_instance_form_fields() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_shipping_instance_form_fields_' + (this.id).str()),
		rt.call_function('array_map', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Method', [
					'WC_Settings_API',
				], &this) },
				rt.ArrayItem{ key: none, val: 'set_defaults' },
			]),
			this.instance_form_fields,
		]),
	])
}

fn (mut this Class_WC_Shipping_Method) get_instance_option_key() string {
	return if rt.is_true(this.instance_id) {
			(rt.get_property(rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this), 'plugin_id')).str() +
			(this.id).str() + '_' + (this.instance_id).str() + '_settings'
	} else {
		''
	}
}

fn (mut this Class_WC_Shipping_Method) init_instance_settings() {
	this.instance_settings = rt.call_function('get_option', [
		rt.new_string(this.get_instance_option_key()),
		rt.new_null(),
	])
	if !(this.instance_settings.is_array()) {
		mut var_form_fields := this.get_instance_form_fields()
		this.instance_settings = rt.call_function('array_merge', [
			rt.call_function('array_fill_keys', [
				rt.func_array_keys(var_form_fields.clone()),
				rt.new_string(''),
			]),
			rt.call_function('wp_list_pluck', [
				var_form_fields.clone(),
				rt.new_string('default'),
			]),
		])
	}
}

fn (mut this Class_WC_Shipping_Method) process_admin_options() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.instance_id)))) {
		return (this.Class_WC_Settings_API.process_admin_options()).to_bool()
	}
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('instance_id')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('instance_id'))]), this.instance_id)))) {
		return false
	}
	this.init_instance_settings()
	mut var_post_data := this.get_post_data()
	mut iter_6 := this.get_instance_form_fields().iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field := item_6.val
		mut var_key := item_6.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('title'),
			this.get_field_type(var_field.clone())))))
		{
			this.instance_settings.array_set(var_key, this.get_field_value(var_key.clone(),
				var_field.clone(), var_post_data.clone()))
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			unsafe {
				goto end_label_1
			}
			catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.clone()
				this.add_error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
				unsafe {
					goto end_label_1
				}
			} else {
				rt.throw_exception(var_e_1)
				unsafe {
					goto end_label_1
				}
			}

			end_label_1:
		}
	}
	return (rt.call_function('update_option', [
		rt.new_string(this.get_instance_option_key()),
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_shipping_' + (this.id).str() + '_instance_settings_values'),
			this.instance_settings,
			rt.new_object('WC_Shipping_Method', ['WC_Settings_API'], &this),
		]),
		rt.new_string('yes'),
	])).to_bool()
}

struct Class_WC_Settings_API {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_WC_Shipping_Rate {
	rt.PhpObjectBase
}

fn create_wc_shipping_method(instance_id i64) &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase:        rt.PhpObjectBase{}
		supports:             rt.new_array()
		id:                   rt.new_string('')
		method_title:         rt.new_string('')
		method_description:   rt.new_string('')
		enabled:              rt.new_string('yes')
		title:                rt.new_null()
		rates:                rt.new_array()
		tax_status:           rt.new_null()
		fee:                  rt.new_null()
		minimum_fee:          rt.new_null()
		instance_id:          rt.new_int(0)
		instance_form_fields: rt.new_array()
		instance_settings:    rt.new_array()
		availability:         rt.new_null()
		countries:            rt.new_array()
		method_order:         rt.new_null()
		has_settings:         rt.new_null()
		settings_html:        rt.new_null()
	}
	obj.construct(instance_id)
	return obj
}

fn create_wc_settings_api(_args ...rt.PhpVal) &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shipping_rate(_args ...rt.PhpVal) &Class_WC_Shipping_Rate {
	mut obj := &Class_WC_Shipping_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Method) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'supports' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.supports(dispatch_arg_0)
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'is_taxable' {
			return rt.new_bool(this.is_taxable())
		}
		'is_enabled' {
			return this.is_enabled()
		}
		'get_instance_id' {
			return this.get_instance_id()
		}
		'get_method_title' {
			return this.get_method_title()
		}
		'get_method_description' {
			return this.get_method_description()
		}
		'get_title' {
			return this.get_title()
		}
		'get_rates_for_package' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_rates_for_package(dispatch_arg_0)
		}
		'get_rate_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_rate_id(dispatch_arg_0)
		}
		'add_rate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_rate(dispatch_arg_0)
			return rt.new_null()
		}
		'get_taxes_per_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_taxes_per_item(dispatch_arg_0)
		}
		'is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_available(dispatch_arg_0)
		}
		'get_fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_fee(dispatch_arg_0, dispatch_arg_1)
		}
		'has_settings' {
			return this.has_settings()
		}
		'get_admin_options_html' {
			return rt.new_string(this.get_admin_options_html())
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_option(dispatch_arg_0, dispatch_arg_1)
		}
		'get_instance_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_instance_option(dispatch_arg_0, dispatch_arg_1)
		}
		'get_instance_form_fields' {
			return this.get_instance_form_fields()
		}
		'get_instance_option_key' {
			return rt.new_string(this.get_instance_option_key())
		}
		'init_instance_settings' {
			this.init_instance_settings()
			return rt.new_null()
		}
		'process_admin_options' {
			return rt.new_bool(this.process_admin_options())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Method) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'supports' { return this.supports }
		'id' { return this.id }
		'method_title' { return this.method_title }
		'method_description' { return this.method_description }
		'enabled' { return this.enabled }
		'title' { return this.title }
		'rates' { return this.rates }
		'tax_status' { return this.tax_status }
		'fee' { return this.fee }
		'minimum_fee' { return this.minimum_fee }
		'instance_id' { return this.instance_id }
		'instance_form_fields' { return this.instance_form_fields }
		'instance_settings' { return this.instance_settings }
		'availability' { return this.availability }
		'countries' { return this.countries }
		'method_order' { return this.method_order }
		'has_settings' { return this.has_settings }
		'settings_html' { return this.settings_html }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Method) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'supports' {
			this.supports = val
			return true
		}
		'id' {
			this.id = val
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
		'enabled' {
			this.enabled = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'rates' {
			this.rates = val
			return true
		}
		'tax_status' {
			this.tax_status = val
			return true
		}
		'fee' {
			this.fee = val
			return true
		}
		'minimum_fee' {
			this.minimum_fee = val
			return true
		}
		'instance_id' {
			this.instance_id = val
			return true
		}
		'instance_form_fields' {
			this.instance_form_fields = val
			return true
		}
		'instance_settings' {
			this.instance_settings = val
			return true
		}
		'availability' {
			this.availability = val
			return true
		}
		'countries' {
			this.countries = val
			return true
		}
		'method_order' {
			this.method_order = val
			return true
		}
		'has_settings' {
			this.has_settings = val
			return true
		}
		'settings_html' {
			this.settings_html = val
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

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shipping_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shipping_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shipping_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
