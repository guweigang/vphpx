import rt

struct Class_WC_Shipping_Flat_Rate {
	rt.PhpObjectBase
pub mut:
	fee_cost  rt.PhpVal = rt.new_string('')
	cost      rt.PhpVal = rt.new_null()
	prop_type rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Shipping_Flat_Rate) construct(instance_id i64) {
	this.dispatch_set_prop('id', rt.new_string('flat_rate'))
	this.dispatch_set_prop('instance_id', rt.call_function('absint', [
		rt.new_int(instance_id),
	]))
	this.dispatch_set_prop('method_title', rt.call_function('__', [
		rt.new_string('Flat rate'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('method_description', rt.call_function('__', [
		rt.new_string('Lets you charge a fixed rate for shipping.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('supports', rt.create_array([
		rt.ArrayItem{ key: none, val: 'shipping-zones' },
		rt.ArrayItem{ key: none, val: 'instance-settings' },
		rt.ArrayItem{ key: none, val: 'instance-settings-modal' },
	]))
	this.init()
	rt.call_function('add_action', [
		rt.new_string('woocommerce_update_options_shipping_' +
			rt.get_property(rt.new_object('WC_Shipping_Flat_Rate', ['WC_Shipping_Method'], &this), 'id')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'process_admin_options' },
		]),
	])
}

fn (mut this Class_WC_Shipping_Flat_Rate) init() {
	this.dispatch_set_prop('instance_form_fields', rt.include_file(@DIR +
		'/includes/settings-flat-rate.php', '1'))
	this.dispatch_set_prop('title', this.get_option(rt.new_string('title')))
	this.dispatch_set_prop('tax_status', this.get_option(rt.new_string('tax_status')))
	this.cost = this.get_option(rt.new_string('cost'))
	this.prop_type = this.get_option(rt.new_string('type'), rt.new_string('class'))
}

fn (mut this Class_WC_Shipping_Flat_Rate) evaluate_cost(var_sum rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_sum_mutated := var_sum
	mut var_args_mutated := var_args
	if !(var_args_mutated.clone().is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.clone().array_isset(rt.new_string('qty')))))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.clone().array_isset(rt.new_string('cost'))))))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.new_string('$args must contain `cost` and `qty` keys.'),
			rt.new_string('4.0.1')])
	}
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/libraries/class-wc-eval-math.php', '2')
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_evaluate_shipping_cost_args'),
		var_args_mutated.clone(),
		var_sum_mutated.clone(),
		rt.new_object('WC_Shipping_Flat_Rate', ['WC_Shipping_Method'], &this),
	])
	mut var_locale := rt.call_function('localeconv', []rt.PhpVal{})
	mut var_decimals := [
		rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{}),
		var_locale.array_get(rt.new_string('decimal_point')),
		var_locale.array_get(rt.new_string('mon_decimal_point')),
		rt.new_string(','),
	]
	this.fee_cost = var_args_mutated.array_get(rt.new_string('cost'))
	rt.call_function('add_shortcode', [rt.new_string('fee'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Flat_Rate', [
				'WC_Shipping_Method',
			], &this) },
			rt.ArrayItem{ key: none, val: 'fee' },
		])])
	var_sum_mutated = rt.call_function('do_shortcode', [
		rt.call_function('str_replace', [
			rt.create_array([rt.ArrayItem{ key: none, val: '[qty]' },
				rt.ArrayItem{ key: none, val: '[cost]' }]),
			rt.create_array([rt.ArrayItem{
				key: none
				val: var_args_mutated.array_get(rt.new_string('qty'))
			}, rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('cost')) }]),
			var_sum_mutated.clone(),
		]),
	])
	rt.call_function('remove_shortcode', [rt.new_string('fee'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Shipping_Flat_Rate', [
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

fn (mut this Class_WC_Shipping_Flat_Rate) fee(var_atts rt.PhpVal) string {
	mut var_atts_mutated := var_atts
	var_atts_mutated = rt.call_function('shortcode_atts', [
		rt.create_array([rt.ArrayItem{ key: 'percent', val: '' },
			rt.ArrayItem{ key: 'min_fee', val: '' }, rt.ArrayItem{ key: 'max_fee', val: '' }]),
		var_atts_mutated.clone(),
		rt.new_string('fee'),
	])
	mut var_calculated_fee := rt.new_int(0)
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('percent'))) {
		var_calculated_fee =
			rt.new_float(this.fee_cost * var_atts_mutated.array_get(rt.new_string('percent')).to_f64() / 100)
		var_calculated_fee = rt.call_function('round', [var_calculated_fee.clone(),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
	}
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('min_fee')))
		&& rt.is_true(rt.less(var_calculated_fee, var_atts_mutated.array_get(rt.new_string('min_fee')))) {
		var_calculated_fee = var_atts_mutated.array_get(rt.new_string('min_fee'))
	}
	if rt.is_true(var_atts_mutated.array_get(rt.new_string('max_fee')))
		&& rt.is_true(rt.greater(var_calculated_fee, var_atts_mutated.array_get(rt.new_string('max_fee')))) {
		var_calculated_fee = var_atts_mutated.array_get(rt.new_string('max_fee'))
	}
	return var_calculated_fee.str()
}

fn (mut this Class_WC_Shipping_Flat_Rate) calculate_shipping(var_package rt.PhpVal) {
	mut var_rate := {
		'id':      this.get_rate_id()
		'label':   rt.get_property(rt.new_object('WC_Shipping_Flat_Rate', [
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
	mut var_shipping_classes := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'shipping', []rt.PhpVal{}), 'get_shipping_classes', []rt.PhpVal{})
	if !(!rt.is_true(var_shipping_classes)) {
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
	}
	if rt.is_true(var_has_costs) {
		this.add_rate(var_rate.clone())
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_' +
			rt.get_property(rt.new_object('WC_Shipping_Flat_Rate', ['WC_Shipping_Method'], &this), 'id') +
			'_shipping_add_rate'),
		rt.new_object('WC_Shipping_Flat_Rate', [
			'WC_Shipping_Method',
		], &this),
		rt.create_array_from_native_map(var_rate),
	])
}

fn (mut this Class_WC_Shipping_Flat_Rate) get_package_item_qty(var_package rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_WC_Shipping_Flat_Rate) find_shipping_classes(var_package rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_WC_Shipping_Flat_Rate) is_math_expression(value string) bool {
	mut value_mutated := value
	mut var_decimal_separator := rt.call_function('wc_get_price_decimal_separator', []rt.PhpVal{})
	mut var_separator := rt.call_function('preg_quote', [var_decimal_separator.clone(),
		rt.new_string('/')])
	return (rt.call_function('preg_match', [
		rt.new_string('/^[\\d' + var_separator.str() + '\\s]+([+\\-*\\/][\\d' +
			var_separator.str() + '\\s]+)+$/'),
		rt.new_string(value_mutated.trim_space()),
	])).to_bool()
}

fn (mut this Class_WC_Shipping_Flat_Rate) sanitize_cost(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() {
		rt.new_string('')
	} else {
		var_value_mutated
	}
	var_value_mutated = rt.call_function('wp_kses_post', [
		rt.new_string(rt.call_function('wp_unslash', [var_value_mutated.clone()]).to_string().trim_space()),
	])
	var_value_mutated = rt.call_function('str_replace', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('get_woocommerce_currency_symbol',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_function('html_entity_decode', [
				rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}),
			]) },
		]),
		rt.new_string(''),
		var_value_mutated.clone(),
	])
	mut var_contains_shortcodes := rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_value_mutated.clone(), rt.new_string('[')])))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_value_mutated.clone(), rt.new_string(']')]))))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_contains_shortcodes))))
		&& !(this.is_math_expression(var_value_mutated.str())) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
		mut iife_result_1 := iife_temp_1.sanitize_cost_in_current_locale(var_value_mutated.clone())
		var_value_mutated = iife_result_1
	}
	mut var_dummy_cost := this.evaluate_cost(var_value_mutated.clone(), rt.create_array([
		rt.ArrayItem{ key: 'cost', val: 1 },
		rt.ArrayItem{ key: 'qty', val: 1 },
	]))
	if rt.is_true(rt.identical(rt.new_bool(false), var_dummy_cost)) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.get_static_prop('WC_Eval_Math',
			'last_error'))))
	}
	return var_value_mutated.clone()
}

struct Class_WC_Shipping_Method {
	rt.PhpObjectBase
}

struct Class_WC_Eval_Math {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_shipping_flat_rate(instance_id i64) &Class_WC_Shipping_Flat_Rate {
	mut obj := &Class_WC_Shipping_Flat_Rate{
		PhpObjectBase: rt.PhpObjectBase{}
		fee_cost:      rt.new_string('')
		cost:          rt.new_null()
		prop_type:     rt.new_null()
	}
	obj.construct(instance_id)
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

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Shipping_Flat_Rate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'evaluate_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.evaluate_cost(dispatch_arg_0, dispatch_arg_1)
		}
		'fee' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.fee(dispatch_arg_0))
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
		'is_math_expression' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_math_expression(dispatch_arg_0))
		}
		'sanitize_cost' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_cost(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Shipping_Flat_Rate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fee_cost' { return this.fee_cost }
		'cost' { return this.cost }
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Shipping_Flat_Rate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
