import rt

struct Class_WC_Shipping_Legacy_Flat_Rate {
	rt.PhpObjectBase
pub mut:
	fee_cost  rt.PhpVal = rt.new_string('')
	cost      rt.PhpVal = rt.new_null()
	prop_type rt.PhpVal = rt.new_null()
	options   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) construct() {
	this.dispatch_set_prop('id', rt.new_string('legacy_flat_rate'))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Flat rate (legacy)'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', '<strong>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This method is deprecated in 2.6.0 and will be removed in future versions - we recommend disabling it and instead setting up a new rate within your <a href="%s">Shipping zones</a>.'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=shipping')])])).str() +
		'</strong>')
	this.init()
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', ['WC_Shipping_Method'], &this), 'id')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('woocommerce_flat_rate_shipping_add_rate'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'calculate_extra_shipping' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) process_admin_options() {
	this.Class_WC_Shipping_Method.process_admin_options()
	if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
		'WC_Shipping_Method',
	], &this), 'settings').array_get(rt.new_string('enabled'))))
	{
		rt.call_function('wp_redirect', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-settings&tab=shipping&section=options'),
			]),
		])
		exit(0)
	}
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) get_option_key() string {
	return
		(rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', ['WC_Shipping_Method'], &this), 'plugin_id')).str() +
		'flat_rate_settings'
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) init() {
	this.init_form_fields()
	this.init_settings()
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('availability', this.get_option(rt.new_string('availability')))
	this.dispatch_set_prop('countries', this.get_option(rt.new_string('countries')))
	this.dispatch_set_prop('tax_status', this.get_option(rt.new_string('tax_status')))
	this.cost = this.get_option(rt.new_string('cost'))
	this.prop_type = this.get_option(rt.new_string('type'), rt.new_string('class'))
	this.options = this.get_option(rt.new_string('options'), rt.new_bool(false))
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) init_form_fields() {
	this.dispatch_set_prop('form_fields', rt.include_file(@DIR + '/includes/settings-flat-rate.php',
		'1'))
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) evaluate_cost(var_sum rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_sum_mutated := var_sum
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/libraries/class-wc-eval-math.php', '2')
	mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_decimals := [
		rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}),
		var_locale.array_get(rt.new_string('decimal_point')),
		var_locale.array_get(rt.new_string('mon_decimal_point')),
	]
	this.fee_cost = var_args.array_get(rt.new_string('cost'))
	rt.call_function('add_shortcode', [rt.new_string('fee'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'fee' },
		])])
	var_sum_mutated = rt.call_function('do_shortcode', [
		rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '[qty]' },
				rt.ArrayItem{ key: none, val: '[cost]' }]),
			rt.create_array([rt.ArrayItem{ key: none, val: var_args.array_get(rt.new_string('qty')) },
				rt.ArrayItem{ key: none, val: var_args.array_get(rt.new_string('cost')) }]),
			var_sum_mutated.clone(),
		]),
	])
	rt.call_function('remove_shortcode', [rt.new_string('fee'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'fee' },
		])])
	var_sum_mutated = rt.call_function('preg_replace', [rt.new_string('/\\s+/'),
		rt.new_string(''), var_sum_mutated.clone()])
	var_sum_mutated = rt.call_function('str_replace', [
		rt.create_array_from_list(var_decimals),
		rt.new_string('.'),
		var_sum_mutated.clone(),
	])
	var_sum_mutated =
		rt.new_string(var_sum_mutated.clone().to_string().trim_left(' \t\n\r').trim_right(' \t\n\r'))
	mut iife_temp_0 := Class_WC_Eval_Math{}
	mut iife_result_0 := iife_temp_0.evaluate(var_sum_mutated.clone())
	return if rt.is_true(var_sum_mutated) { iife_result_0 } else { rt.new_int(0) }
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) fee(var_atts rt.PhpVal) rt.PhpVal {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'percent', val: '' },
			rt.ArrayItem{ key: 'min_fee', val: '' }]),
		var_atts_mutated.clone(),
		rt.new_string('fee'),
	])
	mut var_calculated_fee := rt.new_int(0)
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('percent'))) {
		var_calculated_fee =
			rt.new_float(this.fee_cost * var_atts_mutated.array_get(rt.new_string('percent')).to_f64() / 100)
	}
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('min_fee')))
		&& rt.is_true(rt.less(var_calculated_fee, var_atts_mutated.array_get(rt.new_string('min_fee')))) {
		var_calculated_fee = var_atts_mutated.array_get(rt.new_string('min_fee'))
	}
	return var_calculated_fee.clone()
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) calculate_shipping(var_package rt.PhpVal) {
	mut var_rate := {
		'id':      rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
			'WC_Shipping_Method',
		], &this), 'id')
		'label':   rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', [
			'WC_Shipping_Method',
		], &this), 'title')
		'cost':    rt.new_int(0)
		'package': var_package
	}
	mut var_has_costs := rt.new_bool(false)
	mut var_cost := this.get_option(rt.new_string('cost'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_cost)))) {
		var_has_costs = rt.new_bool(true)
		var_rate['cost'] = this.evaluate_cost(var_cost.clone(), rt.create_array([
			rt.ArrayItem{ key: 'qty', val: this.get_package_item_qty(var_package.clone()) },
			rt.ArrayItem{ key: 'cost', val: var_package.array_get(rt.new_string('contents_cost')) },
		]))
	}
	mut var_found_shipping_classes := this.find_shipping_classes(var_package.clone())
	mut var_highest_class_cost := rt.new_int(0)
	mut iter_1 := var_found_shipping_classes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_products := item_1.val
		mut var_shipping_class := item_1.key
		mut var_shipping_class_term := rt.call_function('get_term_by', [
			rt.new_string('slug'),
			var_shipping_class.clone(),
			rt.new_string('product_shipping_class'),
		])
		mut var_class_cost_string := if rt.is_true(var_shipping_class_term)
			&& rt.is_true(rt.get_property(var_shipping_class_term, 'term_id')) {
			this.get_option(rt.new_string('class_cost_' +
				(rt.get_property(var_shipping_class_term, 'term_id')).str()), this.get_option(rt.new_string(
				'class_cost_' + var_shipping_class.str()), rt.new_string('')))
		} else {
			this.get_option(rt.new_string('no_class_cost'), rt.new_string(''))
		}
		if rt.is_true(rt.identical(rt.new_string(''), var_class_cost_string)) {
			continue
		}
		var_has_costs = rt.new_bool(true)
		mut var_class_cost := this.evaluate_cost(var_class_cost_string.clone(), rt.create_array([
			rt.ArrayItem{ key: 'qty', val: rt.call_function('array_sum', [
				rt.call_function('wp_list_pluck', [var_products.clone(),
					rt.new_string('quantity')]),
			]) },
			rt.ArrayItem{ key: 'cost', val: rt.call_function('array_sum', [
				rt.call_function('wp_list_pluck', [var_products.clone(),
					rt.new_string('line_total')]),
			]) },
		]))
		if rt.is_true(rt.identical(rt.new_string('class'), this.prop_type)) {
			var_rate['cost'] = rt.add(var_rate['cost'], var_class_cost)
		} else {
			var_highest_class_cost = if rt.is_true(rt.greater(var_class_cost,
				var_highest_class_cost))
			{
				var_class_cost
			} else {
				var_highest_class_cost
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_string('order'), this.prop_type))
		&& rt.is_true(var_highest_class_cost) {
		var_rate['cost'] = rt.add(var_rate['cost'], var_highest_class_cost)
	}
	var_rate['package'] = var_package.clone()
	if rt.is_true(var_has_costs) {
		this.add_rate(var_rate.clone())
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_flat_rate_shipping_add_rate'),
		rt.new_object('WC_Shipping_Legacy_Flat_Rate', ['WC_Shipping_Method'], &this),
		rt.create_array_from_native_map(var_rate),
	])
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) get_package_item_qty(var_package rt.PhpVal) rt.PhpVal {
	mut var_total_quantity := rt.new_int(0)
	mut iter_2 := var_package.array_get(rt.new_string('contents')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_values := item_2.val
		mut var_item_id := item_2.key
		if rt.is_true(rt.greater(var_values.array_get(rt.new_string('quantity')), rt.new_int(0)))
			&& rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')), 'needs_shipping', []rt.PhpVal{})) {
			var_total_quantity = rt.add(var_total_quantity,
				var_values.array_get(rt.new_string('quantity')))
		}
	}
	return var_total_quantity.clone()
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) find_shipping_classes(var_package rt.PhpVal) rt.PhpVal {
	mut var_found_shipping_classes := rt.new_array()
	mut iter_3 := var_package.array_get(rt.new_string('contents')).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_values := item_3.val
		mut var_item_id := item_3.key
		if rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')), 'needs_shipping',
			[]rt.PhpVal{}))
		{
			mut var_found_class := rt.call_method(var_values.array_get(rt.new_string('data')),
				'get_shipping_class', []rt.PhpVal{})
			if !(var_found_shipping_classes.array_isset(var_found_class)) {
				var_found_shipping_classes.array_set(var_found_class, rt.new_array())
			}
			var_found_shipping_classes.array_get_mut(var_found_class).array_set(var_item_id,
				var_values.clone())
		}
	}
	return var_found_shipping_classes.clone()
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) calculate_extra_shipping(var_method rt.PhpVal, var_rate rt.PhpVal) {
	mut var_rate_mutated := var_rate
	if rt.is_true(this.options) {
		mut var_options := rt.call_function('array_filter', [
			rt.cast_array(rt.call_function('explode', [rt.new_string('\n'), this.options])),
		])
		mut iter_4 := var_options.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_option := item_4.val
			mut var_this_option := rt.call_function('array_map', [
				rt.new_string('trim'),
				rt.call_function('explode', [
					rt.get_constant('WC_DELIMITER'),
					var_option.clone(),
				])])
			if rt.is_true(rt.new_bool(var_this_option.clone().array_count() != 3)) {
				continue
			}
			mut var_extra_rate := var_rate_mutated.clone()
			var_extra_rate.array_set('id',
				rt.get_property(rt.new_object('WC_Shipping_Legacy_Flat_Rate', ['WC_Shipping_Method'], &this), 'id') +
				':' +(rt.call_function('urldecode', [rt.call_function('sanitize_title', [var_this_option.array_get(rt.new_int(0))])])).str())
			var_extra_rate.array_set('label', var_this_option.array_get(rt.new_int(0)))
			mut var_extra_cost := this.get_extra_cost(var_this_option.array_get(rt.new_int(1)),
				var_this_option.array_get(rt.new_int(2)),
				var_rate_mutated.array_get(rt.new_string('package')))
			if rt.is_true(rt.new_bool(var_extra_rate.array_get(rt.new_string('cost')).is_array())) {
				var_extra_rate.array_get_mut('cost').array_set('order', rt.add(var_extra_rate.array_get(rt.new_string('cost')).array_get(rt.new_string('order')),
					var_extra_cost))
			} else {
				var_extra_rate.array_get(rt.new_string('cost')) = rt.add(var_extra_rate.array_get(rt.new_string('cost')),
					var_extra_cost)
			}
			this.add_rate(var_extra_rate.clone())
		}
	}
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) calc_percentage_adjustment(var_cost rt.PhpVal, var_percent_adjustment rt.PhpVal, var_percent_operator rt.PhpVal, var_base_price rt.PhpVal) rt.PhpVal {
	mut var_cost_mutated := var_cost
	if rt.is_true(rt.identical(rt.new_string('+'), var_percent_operator)) {
		var_cost_mutated = rt.add(var_cost_mutated, rt.mul(var_percent_adjustment, var_base_price))
	} else {
		var_cost_mutated = rt.sub(var_cost_mutated, rt.mul(var_percent_adjustment, var_base_price))
	}
	return var_cost_mutated.clone()
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) get_extra_cost(var_cost_string rt.PhpVal, var_type rt.PhpVal, var_package rt.PhpVal) rt.PhpVal {
	mut var_this_cost_matches := []rt.PhpVal{}
	mut var_cost := var_cost_string
	mut var_cost_percent := rt.new_bool(false)
	mut var_pattern := rt.new_string('/' + '(\\d+\\.?\\d*)' + '\\s*' + '(\\+|-)' + '\\s*' +
		'(\\d+\\.?\\d*)' + '\\%/')
	if rt.is_true(rt.call_function('preg_match', [var_pattern.clone(),
		var_cost_string.clone(), rt.create_array_from_list(var_this_cost_matches)]))
	{
		mut var_cost_operator := var_this_cost_matches.array_get(rt.new_int(2))
		var_cost_percent = rt.div(var_this_cost_matches.array_get(rt.new_int(3)), rt.new_int(100))
		var_cost = var_this_cost_matches.array_get(rt.new_int(1))
	}
	mut switch_val_1 := var_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('class'))) {
		var_cost = rt.mul(var_cost,
			rt.new_int(this.find_shipping_classes(var_package.clone()).array_count()))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('item'))) {
		var_cost = rt.mul(var_cost, this.get_package_item_qty(var_package.clone()))
	}
	if rt.is_true(var_cost_percent) {
		mut switch_val_2 := var_type
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('class'))) {
			mut var_shipping_classes := this.find_shipping_classes(var_package.clone())
			mut iter_5 := var_shipping_classes.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_items := item_5.val
				mut var_shipping_class := item_5.key
				mut iter_6 := var_items.iterator()
				for {
					item_6 := iter_6.next() or { break }
					mut var_values := item_6.val
					mut var_item_id := item_6.key
					var_cost = this.calc_percentage_adjustment(var_cost.clone(),
						var_cost_percent.clone(), var_cost_operator.clone(),
						var_values.array_get(rt.new_string('line_total')))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('item'))) {
			mut iter_7 := var_package.array_get(rt.new_string('contents')).iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_values := item_7.val
				mut var_item_id := item_7.key
				if rt.is_true(rt.call_method(var_values.array_get(rt.new_string('data')),
					'needs_shipping', []rt.PhpVal{}))
				{
					var_cost = this.calc_percentage_adjustment(var_cost.clone(),
						var_cost_percent.clone(), var_cost_operator.clone(),
						var_values.array_get(rt.new_string('line_total')))
				}
			}
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('order'))) {
			var_cost = this.calc_percentage_adjustment(var_cost.clone(), var_cost_percent.clone(),
				var_cost_operator.clone(), var_package.array_get(rt.new_string('contents_cost')))
		}
	}
	return var_cost.clone()
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

struct Class_WC_Eval_Math {
	rt.PhpObjectBase
}

fn create_wc_shipping_legacy_flat_rate() &Class_WC_Shipping_Legacy_Flat_Rate {
	mut obj := &Class_WC_Shipping_Legacy_Flat_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
		fee_cost:      rt.new_string('')
		cost:          rt.new_null()
		prop_type:     rt.new_null()
		options:       rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wc_shipping_method(_args ...rt.PhpVal) &Class_WC_Shipping_Method {
	mut obj := &Class_WC_Shipping_Method{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_eval_math(_args ...rt.PhpVal) &Class_WC_Eval_Math {
	mut obj := &Class_WC_Eval_Math{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'evaluate_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.evaluate_cost(dispatch_arg_0, dispatch_arg_1)
		}
		'fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.fee(dispatch_arg_0)
		}
		'calculate_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.calculate_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'get_package_item_qty' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_package_item_qty(dispatch_arg_0)
		}
		'find_shipping_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_shipping_classes(dispatch_arg_0)
		}
		'calculate_extra_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.calculate_extra_shipping(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'calc_percentage_adjustment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.calc_percentage_adjustment(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'get_extra_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_extra_cost(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Legacy_Flat_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fee_cost' { return this.fee_cost }
		'cost' { return this.cost }
		'type' { return this.prop_type }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Legacy_Flat_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fee_cost' {
			this.fee_cost = val
			return true
		}
		'cost' {
			this.cost = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'options' {
			this.options = val
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

fn (mut this Class_WC_Eval_Math) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Eval_Math) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Eval_Math) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
