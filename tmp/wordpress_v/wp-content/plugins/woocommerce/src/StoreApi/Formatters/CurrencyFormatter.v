import rt

struct Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter) format(var_value rt.PhpVal, mut var_options Class_Automattic_WooCommerce_StoreApi_Formatters_array) rt.PhpVal {
	mut var_position := rt.call_function('get_option', [
		rt.new_string('woocommerce_currency_pos'),
	])
	mut var_symbol := rt.call_function('html_entity_decode', [
		rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}),
	])
	mut var_prefix := rt.new_string(rt.new_string(''))
	mut var_suffix := rt.new_string(rt.new_string(''))
	mut switch_val_1 := var_position
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('left_space'))) {
		var_prefix = rt.new_string(var_symbol.str() + ' ')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('left'))) {
		var_prefix = var_symbol.dup()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('right_space'))) {
		var_suffix = rt.new_string(' ' + var_symbol.str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('right'))) {
		var_suffix = var_symbol.dup()
	}
	return rt.call_function('array_merge', [rt.cast_array(var_value),
		rt.create_array([
			rt.ArrayItem{ key: 'currency_code', val: rt.call_function('get_woocommerce_currency',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'currency_symbol', val: var_symbol },
			rt.ArrayItem{ key: 'currency_minor_unit', val: rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'currency_decimal_separator', val: rt.call_function('wc_get_price_decimal_separator',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'currency_thousand_separator', val: rt.call_function('wc_get_price_thousand_separator',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'currency_prefix', val: var_prefix },
			rt.ArrayItem{ key: 'currency_suffix', val: var_suffix },
		])])
}

fn create_automattic_woocommerce_storeapi_formatters_currencyformatter() &Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'format' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Formatters_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.format(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Formatters_CurrencyFormatter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_formatters_currencyformatter_php() {
}
