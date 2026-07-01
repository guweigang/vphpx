import rt

struct Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) format(var_value rt.PhpVal, mut var_options Class_Automattic_WooCommerce_StoreApi_Formatters_array) string {
	mut var_value_mutated := var_value
	mut var_options_mutated := var_options
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_string())))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_double())))))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN),
			rt.new_string('Function expects a $value arg of type INT, STRING or FLOAT.'),
			rt.new_string('9.2')])
		return ''
	}
	var_options_mutated = rt.call_function('wp_parse_args', [
		var_options_mutated.dup(),
		rt.create_array([
			rt.ArrayItem{ key: 'decimals', val: rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'rounding_mode', val: rt.get_constant('PHP_ROUND_HALF_UP') },
		])])
	mut var_rounding_modes := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.get_constant('PHP_ROUND_HALF_UP') },
		rt.ArrayItem{ key: none, val: rt.get_constant('PHP_ROUND_HALF_DOWN') },
		rt.ArrayItem{ key: none, val: rt.get_constant('PHP_ROUND_HALF_EVEN') },
		rt.ArrayItem{ key: none, val: rt.get_constant('PHP_ROUND_HALF_ODD') },
	])
	var_options_mutated.array_set('rounding_mode', rt.call_function('absint', [
		var_options_mutated.array_get('rounding_mode'),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_options_mutated.array_get('rounding_mode'),
		var_rounding_modes.dup(),
		rt.new_bool(true),
	])))))
	{
		var_options_mutated.array_set('rounding_mode', rt.get_constant('PHP_ROUND_HALF_UP'))
	}
	var_value_mutated = rt.new_float(rt.new_float(var_value_mutated.dup().to_f64()))
	var_value_mutated = rt.mul(var_value_mutated, rt.call_function('pow', [
		rt.new_int(10),
		rt.call_function('absint', [var_options_mutated.array_get('decimals')]),
	]))
	var_value_mutated = rt.call_function('round', [var_value_mutated.dup(),
		rt.new_int(0), var_options_mutated.array_get('rounding_mode')])
	return (rt.call_function('wc_format_decimal', [var_value_mutated.dup(),
		rt.new_int(0), rt.new_bool(true)])).str()
}

fn create_automattic_woocommerce_storeapi_formatters_moneyformatter() &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Formatters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.format(dispatch_arg_0, mut dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_MoneyFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_formatters_moneyformatter_php() {
}
